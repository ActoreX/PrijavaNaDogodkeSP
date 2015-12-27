using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EventiqonWebApp.Models;
using RestSharp;
using System.Transactions;

namespace EventiqonWebApp.Controllers
{
    public class OrganizerController : Controller
    {

        EventiqonEntities db = new EventiqonEntities();

        // GET: Organizer/AddNewActivity
        [HttpGet]
        public ActionResult AddNewActivity()
        {
            return View();
        }

        // POST: Organizer/AddNewActivity
        [HttpPost]
        public JsonResult AddNewActivity(AktivnostDogodekVhodniPodatki vhod)
        {
            string odgovor = "Odgovor strežnka: ";
            GoogleMapsGeocodingModel googleMapsModel = null;
            if (obveznaPoljaPodanaAktivnostDogodekVhodniPodatki(vhod))
            {
                // GET: (klic Google Maps APIja za geodecoding
                // https://maps.googleapis.com/maps/api/geocode/json?latlng=46.06813252000273,14.544028793945245&key=AIzaSyAmZRoA4MHaKQDY4JuWnkV3ZB-k69kluts

                var restClient = new RestClient("https://maps.googleapis.com");
                var request = new RestRequest(Method.GET);
                request.Resource = "maps/api/geocode/json";
                request.AddParameter("latlng", vhod.geolocation_lat + "," + vhod.geolocation_lon);
                request.AddParameter("key", "AIzaSyAmZRoA4MHaKQDY4JuWnkV3ZB-k69kluts");

                var response = restClient.Execute<GoogleMapsGeocodingModel>(request);

                googleMapsModel = response.Data;
                if(googleMapsModel.status == "OK")
                {
                    var kraj = googleMapsModel.results[5].address_components[1].long_name;
                    var drzavaKratica = googleMapsModel.results[5].address_components[2].short_name;
                    var drzavaIme = googleMapsModel.results[5].address_components[2].long_name;

                    using (TransactionScope ts = new TransactionScope(TransactionScopeOption.RequiresNew))
                    {
                        try {
                            Kraj kr = null;
                            // preveri če mesto(kraj) v bazi že obstaja 
                            if (!db.Kraj.Any(k => k.nazivKraja == kraj))
                            {
                                kr = new Kraj();
                                kr.nazivKraja = kraj;
                                kr.idKraj = db.Kraj.Max(k => k.idKraj) + 1;
                                db.Kraj.Add(kr);
                                db.SaveChanges();

                            }
                            else
                            {
                                kr = db.Kraj.Where(k => k.nazivKraja == kraj).Take(1).Single();
                            }

                            Drzava dr = null;
                            // Preveri ali država obstaja, če ne jo dodaj
                            if (!db.Drzava.Any(d => d.kraticaDrzave == drzavaKratica))
                            {
                                dr = new Drzava();
                                dr.kraticaDrzave = drzavaKratica;
                                dr.imeDrzave = drzavaIme;
                                db.Drzava.Add(dr);
                                db.SaveChanges();
                                odgovor += "Država vstavljena v db! ";
                            }
                            else
                            {
                                dr = db.Drzava.Where(d => d.kraticaDrzave == drzavaKratica).Take(1).Single();
                            }

                            Aktivnost novaAktivnost = new Aktivnost();
                            novaAktivnost.idAktivnost = db.Aktivnost.Max(a => a.idAktivnost) + 1;
                            novaAktivnost.idKraj = kr.idKraj;
                            novaAktivnost.jeEnkratna = (vhod.vrstaIzbireTrajanja == "enkratna");
                            novaAktivnost.kraticaDrzave = dr.kraticaDrzave;
                            novaAktivnost.latitude = Convert.ToDouble(vhod.geolocation_lat);
                            novaAktivnost.longitude = Convert.ToDouble(vhod.geolocation_lon);
                            novaAktivnost.naziv = vhod.nazivIzbire; // naziv aktivonosti (dogodka)
                            novaAktivnost.nazivLokacije = vhod.vnosLokacije;
                            novaAktivnost.opis = vhod.opisAktEvn;
                            novaAktivnost.status = "neznano";
                            novaAktivnost.cena = vhod.cenaVstopnice;
                            novaAktivnost.datumOd = Convert.ToDateTime(vhod.datum_od);
                            // če datum do obstaja
                            if (vhod.datum_do != null)
                            {
                                novaAktivnost.datumDo = Convert.ToDateTime(vhod.datum_do);
                            }
                            if (vhod.stMestOmejitevAktEvn != null && vhod.stMestOmejitevAktEvn == "omejeno")
                            {
                                novaAktivnost.omejitevMest = Convert.ToInt32(vhod.steviloMestSpinner);
                            }
                            novaAktivnost.datumVnosa = DateTime.Now;

                            db.Aktivnost.Add(novaAktivnost);
                            db.SaveChanges();

                            // postavke aktivnosti(dogodka)
                            foreach (var postavka in vhod.seznamPostavk)
                            {
                                PostavkaAktivnosti novaPostavka = new PostavkaAktivnosti();
                                novaPostavka.idPostavkaAktivnosti = db.PostavkaAktivnosti.Max(pa => pa.idPostavkaAktivnosti) + 1;
                                novaPostavka.idAktivnost = novaAktivnost.idAktivnost;
                                novaPostavka.casovniOpisKdaj = postavka.casPostavke;
                                novaPostavka.opisCasaTrajanja = postavka.casTrajanjaPostavke;
                                novaPostavka.naziv = postavka.nazivPostavke;
                                novaPostavka.polniOpis = postavka.opisPostavke;
                                db.PostavkaAktivnosti.Add(novaPostavka);
                                db.SaveChanges();
                            }

                            // commitaj transakcijo
                            odgovor += "Uspešno dodajanje aktivnosti v bazo!";
                            ts.Complete();

                        } catch (Exception ex)
                        {
                            odgovor += "Neuspešno dodajanje aktivnosti v bazo! Več informacij: " + ex.Message;
                        }
                    }

                } else
                {
                    odgovor += "Napaka pri pridobivanju podatkov o geolokaciji";
                }
               

            } else
            {
                odgovor += "Neustrezen vnos forme!";
            }
            return Json(odgovor, JsonRequestBehavior.DenyGet);
        }

        bool obveznaPoljaPodanaAktivnostDogodekVhodniPodatki(AktivnostDogodekVhodniPodatki vhod)
        {
            // preveri obvezna polja
            if (vhod.nazivIzbire != null && vhod.datum_od != null && vhod.vrstaIzbireTrajanja != null && vhod.geolocation_lat != null && vhod.geolocation_lon != null && vhod.vnosLokacije != null
                && vhod.opisAktEvn != null && (vhod.vrstaIzbireTrajanja == "enkratna" && vhod.datum_do != null || vhod.vrstaIzbireTrajanja == "ponavljajoca"))
                return true;

            return false;
        }

      

        // GET: Organizer/AddNewEvent
        [HttpGet]   
        public ActionResult AddNewEvent()
        {
            return View();
        }

        // POST: Organizer/AddNewEvent
        [HttpPost]
        public JsonResult AddNewEvent(AktivnostDogodekVhodniPodatki vhod)
        {
            string odgovor = "Odgovor strežnka: ";
            GoogleMapsGeocodingModel googleMapsModel = null;
            if (obveznaPoljaPodanaAktivnostDogodekVhodniPodatki(vhod))
            {
                // GET: (klic Google Maps APIja za geodecoding
                // https://maps.googleapis.com/maps/api/geocode/json?latlng=46.06813252000273,14.544028793945245&key=AIzaSyAmZRoA4MHaKQDY4JuWnkV3ZB-k69kluts

                var restClient = new RestClient("https://maps.googleapis.com");
                var request = new RestRequest(Method.GET);
                request.Resource = "maps/api/geocode/json";
                request.AddParameter("latlng", vhod.geolocation_lat + "," + vhod.geolocation_lon);
                request.AddParameter("key", "AIzaSyAmZRoA4MHaKQDY4JuWnkV3ZB-k69kluts");

                var response = restClient.Execute<GoogleMapsGeocodingModel>(request);

                googleMapsModel = response.Data;
                if (googleMapsModel.status == "OK")
                {
                    var kraj = googleMapsModel.results[5].address_components[1].long_name;
                    var drzavaKratica = googleMapsModel.results[5].address_components[2].short_name;
                    var drzavaIme = googleMapsModel.results[5].address_components[2].long_name;

                    using (TransactionScope ts = new TransactionScope(TransactionScopeOption.RequiresNew))
                    {
                        try
                        {
                            Kraj kr = null;
                            // preveri če mesto(kraj) v bazi že obstaja 
                            if (!db.Kraj.Any(k => k.nazivKraja == kraj))
                            {
                                kr = new Kraj();
                                kr.nazivKraja = kraj;
                                kr.idKraj = db.Kraj.Max(k => k.idKraj) + 1;
                                db.Kraj.Add(kr);
                                db.SaveChanges();

                            }
                            else
                            {
                                kr = db.Kraj.Where(k => k.nazivKraja == kraj).Take(1).Single();
                            }

                            Drzava dr = null;
                            // Preveri ali država obstaja, če ne jo dodaj
                            if (!db.Drzava.Any(d => d.kraticaDrzave == drzavaKratica))
                            {
                                dr = new Drzava();
                                dr.kraticaDrzave = drzavaKratica;
                                dr.imeDrzave = drzavaIme;
                                db.Drzava.Add(dr);
                                db.SaveChanges();
                                odgovor += "Država vstavljena v db! ";
                            }
                            else
                            {
                                dr = db.Drzava.Where(d => d.kraticaDrzave == drzavaKratica).Take(1).Single();
                            }

                            Dogodek novDogodek = new Dogodek();
                            novDogodek.idDogodek = db.Dogodek.Max(a => a.idDogodek) + 1;
                            novDogodek.idKraj = kr.idKraj;
                            novDogodek.kraticaDrzave = dr.kraticaDrzave;
                            novDogodek.latitude = Convert.ToDouble(vhod.geolocation_lat);
                            novDogodek.longitude = Convert.ToDouble(vhod.geolocation_lon);
                            novDogodek.naziv = vhod.nazivIzbire; // naziv aktivonosti (dogodka)
                            novDogodek.nazivLokacije = vhod.vnosLokacije;
                            novDogodek.opis = vhod.opisAktEvn;
                            novDogodek.status = "neznano";
                            novDogodek.cena = vhod.cenaVstopnice;
                            novDogodek.datumOd = Convert.ToDateTime(vhod.datum_od);
                            novDogodek.datumDo = Convert.ToDateTime(vhod.datum_do);
                            
                            if (vhod.stMestOmejitevAktEvn != null && vhod.stMestOmejitevAktEvn == "omejeno")
                            {
                                novDogodek.omejitevMest = Convert.ToInt32(vhod.steviloMestSpinner);
                            }
                            novDogodek.datumVnosa = DateTime.Now;

                            db.Dogodek.Add(novDogodek);
                            db.SaveChanges();

                            // postavke aktivnosti(dogodka)
                            foreach (var postavka in vhod.seznamPostavk)
                            {
                                PostavkaDogodka novaPostavka = new PostavkaDogodka();
                                novaPostavka.idPostavkaDogodka = db.PostavkaDogodka.Max(pa => pa.idPostavkaDogodka) + 1;
                                novaPostavka.idDogodek = novDogodek.idDogodek;
                                novaPostavka.casovniOpisKdaj = postavka.casPostavke;
                                novaPostavka.opisCasaTrajanja = postavka.casTrajanjaPostavke;
                                novaPostavka.naziv = postavka.nazivPostavke;
                                novaPostavka.polniOpis = postavka.opisPostavke;
                                db.PostavkaDogodka.Add(novaPostavka);
                                db.SaveChanges();
                            }

                            // commitaj transakcijo
                            odgovor += "Uspešno dodajanje dogodka v bazo!";
                            ts.Complete();

                        }
                        catch (Exception ex)
                        {
                            odgovor += "Neuspešno dodajanje dogodka v bazo! Več informacij: " + ex.Message;
                        }
                    }

                }
                else
                {
                    odgovor += "Napaka pri pridobivanju podatkov o geolokaciji";
                }


            }
            else
            {
                odgovor += "Neustrezen vnos forme!";
            }
            return Json(odgovor, JsonRequestBehavior.DenyGet);
        }

        // GET: Organizer/Organizer
        public ActionResult Organizer()
        {
            return View();
        }
    }
}