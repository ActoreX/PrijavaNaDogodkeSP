using EventiqonWebApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Transactions;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Security.Claims;

namespace EventiqonWebApp.Controllers
{
    public class UserProfileController : Controller
    {
        EventiqonEntities db = new EventiqonEntities();
      
        // GET UserProfile or UserProfile/UserPanel
        public ActionResult UserPanel()
        {
            // recimo da je prijavljen (prvi) uporabnik; TODO spremeni
            // Uporabnik u = db.Uporabnik.Take(1).Single();
            
            var claimsIdentity = User.Identity as ClaimsIdentity;
            var upIme = claimsIdentity.FindFirst(ClaimTypes.GivenName).Value;

            Uporabnik u = db.Uporabnik.Where(x => x.uprabniskoIme == upIme).Single();

            return View(u);
        }

        // GET UserProfile/UserInbox
        public ActionResult UserInbox()
        {
            // Uporabnik up = db.Uporabnik.Take(1).ToArray()[0];

            var claimsIdentity = User.Identity as ClaimsIdentity;
            var upIme = claimsIdentity.FindFirst(ClaimTypes.GivenName).Value;
            Uporabnik up = db.Uporabnik.Where(x => x.uprabniskoIme == upIme).Single();

            return View(db.Obvestilo.Where(prejemnik => prejemnik.uprabniskoIme == up.uprabniskoIme).OrderByDescending(o=>o.datum).ToArray());
        }

        // POST UserProfile/PosodobiOsebniPodatki
        [HttpPost]
        public JsonResult PosodobiOsebniPodatki(OsebniPodatkiVhodniPodatki vhod)
        {
            string odgovor = "Odgovor strežnika: ";
            Uporabnik u = db.Uporabnik.Take(1).Single();
            // posta
            if (vhod.eposta != null)
            {
                if (jeVeljavenEmail(vhod.eposta))
                {
                    u.email = vhod.eposta;
                    db.SaveChanges();
                    odgovor += "Email uspešno shranjen! ";
                } else
                {
                    odgovor += "Email je neustreznega formata! ";
                }
            } else
            {
                return Json("Napaka! Email je obvezno polje!");
            }
            // datum rojstva
            if(vhod.datumRojstva != null)
            {
                try
                {
                    DateTime dt = Convert.ToDateTime(vhod.datumRojstva);
                    u.datumRojstva = dt;
                    db.SaveChanges();
                    odgovor += "Datum rojstva je uspešno shranjen! ";
                } catch (FormatException fe)
                {
                    odgovor += "Datum je neustreznega formata! ";
                }
            }
            // telefon
            if(vhod.telSt != null)
            {
                Regex rx1 = new Regex(@"^\d{2,3}[-\/]\d{3,4}[-\/]\d{3}$");
                Regex rx2 = new Regex(@"^\d{9}$");
                if(rx1.IsMatch(vhod.telSt) || rx2.IsMatch(vhod.telSt))
                {
                    u.telefon = vhod.telSt;
                    db.SaveChanges();
                    odgovor += "Telefonska številka uspešno vnesena! ";
                } else
                {
                    odgovor += "Telefonska številka neustreznega formata! ";
                }
            }

            // paypal račun
            if(vhod.paypalRacun != null)
            {
                if (jeVeljavenEmail(vhod.paypalRacun))
                {
                    u.paypalRacun = vhod.paypalRacun;
                    db.SaveChanges();
                    odgovor += "Paypal račun uspešno vnesen! ";
                } else
                {
                    odgovor += "Paypal račun ni veljaven - vnesite polno ime (enaslov)! ";
                }
            }
            

            return Json(odgovor, JsonRequestBehavior.DenyGet);
        }

        // POST UserProfile/UserPanel/PosodobiNaslov
        [HttpPost]
        public JsonResult PosodobiNaslov(NaslovVhodniPodatki vhod)
        {
            string odgovor = "Odgovor strežnika: ";
            using (TransactionScope ts = new TransactionScope(TransactionScopeOption.RequiresNew))
            {

                try
                {
                    if (vhod == null || vhod.hisnaStevilka == null || vhod.kraj == null || vhod.postnaStevilka == null || vhod.ulica == null)
                        throw new Exception("Manjkajoča polja!");

                    // Preveri ali država obstaja, če ne jo dodaj // zaenkrat se omejimo samo na Slovenijo (v nadaljne bo potrebno dodati tudi 1 vnosno polje za države)
                    if (!db.Drzava.Any(d => d.imeDrzave == "Slovenia"))
                    {
                        Drzava novaDrzava = new Drzava();
                        novaDrzava.kraticaDrzave = "SI";
                        novaDrzava.imeDrzave = "Slovenia";
                        db.Drzava.Add(novaDrzava);
                        db.SaveChanges();
                        odgovor += "Država vstavljena v db! ";
                    }
                    // Preveri ali kraj obstaja, če ne ga dodaj
                    if (!db.Kraj.Any(k => k.nazivKraja == vhod.kraj))
                    {
                        Kraj novKraj = new Kraj();
                        novKraj.nazivKraja = vhod.kraj;
                        novKraj.idKraj = db.Kraj.Max(k=>k.idKraj) + 1;
                        db.Kraj.Add(novKraj);

                        db.SaveChanges();


                        odgovor += "Uspešno dodan kraj!" + novKraj.idKraj;

                    }

                    // Ustvari nov naslov 
                    Naslov novNaslov = new Naslov();
                    novNaslov.idNaslov = db.Naslov.Max(n => n.idNaslov) + 1;
                    novNaslov.idKraj = db.Kraj.Where(k => k.nazivKraja == vhod.kraj).Select(k => k.idKraj).Take(1).Single();
                    novNaslov.kraticaDrzave = "SI";
                    novNaslov.hisnaStevilka = vhod.hisnaStevilka;
                    novNaslov.ulica = vhod.ulica;
                    db.Naslov.Add(novNaslov);
                    db.SaveChanges();

                    // Uporabnik spremeni naslov - izbriši starega in mu priredi novo ustvarjenega ! če je id kraja 24 oz. naziv / potem ga NE izbriši !
                    // TODO hardcoded: za prvega uporabnika
                    // Uporabnik u = db.Uporabnik.Take(1).Single();

                    var claimsIdentity = User.Identity as ClaimsIdentity;
                    var upIme = claimsIdentity.FindFirst(ClaimTypes.GivenName).Value;
                    Uporabnik u = db.Uporabnik.Where(x => x.uprabniskoIme == upIme).Single();

                    int idStariNaslov = u.idNaslov;
                    u.idNaslov = novNaslov.idNaslov;
                    db.SaveChanges();

                    Naslov stariNaslov = db.Naslov.Where(n => n.idNaslov == idStariNaslov).Single();
                    if (stariNaslov.idNaslov != 26)
                    {
                        db.Naslov.Remove(stariNaslov);
                        db.SaveChanges();
                    }

                    // Transakcija uspešno izvedena, commitaj spremembe
                    ts.Complete();
                    odgovor += "Vnos sprememb uspešen!";

                } catch(Exception ex)
                {
                    odgovor = "Sprememba podatkov neuspešna!";
                }
            }
            return Json(odgovor, JsonRequestBehavior.DenyGet);
        }


        // POST UserProfile/PosodobiGeslo
        [HttpPost]
        public JsonResult PosodobiGeslo(GesloVhodniPodatki vhod)
        {
            string odgovor = "Odgovor strežnika: ";

            // Uporabnik u = db.Uporabnik.Take(1).Single();
            var claimsIdentity = User.Identity as ClaimsIdentity;
            var upIme = claimsIdentity.FindFirst(ClaimTypes.GivenName).Value;
            Uporabnik u = db.Uporabnik.Where(x => x.uprabniskoIme == upIme).Single();

            if (vhod.novoGeslo != null && vhod.ponovniVnosGesla != null && vhod.staroGeslo != null)
            {
                if(u.geslo == vhod.staroGeslo)
                {
                    if(vhod.novoGeslo == vhod.ponovniVnosGesla && vhod.novoGeslo.Length >= 5)
                    {
                        u.geslo = vhod.novoGeslo;
                        try
                        {
                            db.SaveChanges();
                            odgovor += "Uspešno ste spremenili geslo! ";
                        } catch(Exception e)
                        {
                            odgovor += "Prišlo je do  napake!";
                        }
                    } else
                    {
                        odgovor += "Gesli se morata ujemati in biti dolgi vsaj 5 znakov! ";
                    }
                } else
                {
                    odgovor += "Vnesli ste napačno geslo! ";
                }
            } else
            {
               odgovor += "Vsa vnosna polja so obvezna!";
            }


            return Json(odgovor, JsonRequestBehavior.DenyGet);
        }


        // POST UserProfile/PosodobiObnovaRacuna
        [HttpPost]
        public JsonResult PosodobiObnovaRacuna(ObnovaRacunaVhodniPodatki vhod)
        {
            string odgovor = "Odgovor strežnika: ";
            // Uporabnik u = db.Uporabnik.Take(1).Single();
            var claimsIdentity = User.Identity as ClaimsIdentity;
            var upIme = claimsIdentity.FindFirst(ClaimTypes.GivenName).Value;
            Uporabnik u = db.Uporabnik.Where(x => x.uprabniskoIme == upIme).Single();

            if (vhod.pomozniEmail != null && vhod.ponovniVnosPomoznegaEmaila!= null && vhod.telStZaObnovitev != null)
            {
                if (vhod.pomozniEmail == vhod.ponovniVnosPomoznegaEmaila && jeVeljavenEmail(vhod.pomozniEmail))
                {
                    // telefon
                    if (vhod.telStZaObnovitev != null)
                    {
                        Regex rx1 = new Regex(@"^\d{2,3}[-\/]\d{3,4}[-\/]\d{3}$");
                        Regex rx2 = new Regex(@"^\d{9}$");
                        if (rx1.IsMatch(vhod.telStZaObnovitev) || rx2.IsMatch(vhod.telStZaObnovitev))
                        {
                            // načeloma se lahko spremeni (doda nov telefon) če bi bilo potrebno
                            u.telefon = vhod.telStZaObnovitev;
                            db.SaveChanges();
                            odgovor += "Telefonska številka uspešno vnesena! ";
                        }
                        else
                        {
                            odgovor += "Telefonska številka neustreznega formata! ";
                        }
                    } else
                    {
                        odgovor += "Telefon je obvezen parameter!";
                    }
                } else
                {
                    odgovor += "Enaslova sta neustreznega formata ali pa se ne ujemata! ";
                }
            } else
            {
                odgovor += "Vsa polja so obvezna! ";
            }


            return Json(odgovor, JsonRequestBehavior.DenyGet);
        }


        // POST UserProfile/IzbrisRacuna
        [HttpPost]
        public JsonResult IzbrisRacuna(IzbrisRacunaVhodniPodatki vhod)
        {
            string odgovor = "Odgovor strežnika: ";
            // Uporabnik u = db.Uporabnik.Take(2).ToArray()[1]; // vedno "zbriši" drugega za namen demonstracije

            var claimsIdentity = User.Identity as ClaimsIdentity;
            var upIme = claimsIdentity.FindFirst(ClaimTypes.GivenName).Value;
            Uporabnik u = db.Uporabnik.Where(x => x.uprabniskoIme == upIme).Single();

            if (vhod.izbrisGeslo != null && vhod.izbrisUpIme != null) {
                if(u.uprabniskoIme == vhod.izbrisUpIme && u.geslo == vhod.izbrisGeslo)
                {
                    u.status = "izbrisan";
                    IzbrisanRacun ir = new IzbrisanRacun();
                    ir.uprabniskoIme = u.uprabniskoIme;
                    ir.datum = DateTime.Now;
                    if(vhod.izbrisRazlog != null)
                        ir.razlog = vhod.izbrisRazlog;
                    db.IzbrisanRacun.Add(ir);
                    db.SaveChanges();
                    odgovor += "Uporabnik uspešno odstranjen!";
                    var ctx = Request.GetOwinContext();
                    var authManager = ctx.Authentication;

                    authManager.SignOut("EventiqonApplicationCookie");
                }
            } else {
                odgovor += "Uporabniško ime in geslo sta obvezna!";
            }
            

            return Json(odgovor, JsonRequestBehavior.DenyGet);
        }
        



        // Pomožna metoda za validacijo email naslova
        bool jeVeljavenEmail(string email)
        {
            try
            {
                MailAddress ma = new MailAddress(email);
                return true;
            } catch (Exception e)
            {
                return false;
            }
        }
       
    }
}