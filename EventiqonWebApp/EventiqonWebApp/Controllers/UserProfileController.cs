using EventiqonWebApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Transactions;

namespace EventiqonWebApp.Controllers
{
    public class UserProfileController : Controller
    {
        EventiqonEntities db = new EventiqonEntities();
      
        // GET UserProfile or UserProfile/UserPanel
        public ActionResult UserPanel()
        {
            return View();
        }

        // GET UserProfile/UserInbox
        public ActionResult UserInbox()
        {
            Uporabnik up = db.Uporabnik.Take(1).ToArray()[0];

            return View(db.Obvestilo.Where(prejemnik => prejemnik.uprabniskoIme == up.uprabniskoIme).OrderByDescending(o=>o.datum).ToArray());
        }

        // POST UserProfile/PosodobiOsebniPodatki
        [HttpPost]
        public JsonResult PosodobiOsebniPodatki(OsebniPodatkiVhodniPodatki vhod)
        {

            return Json("hehc he", JsonRequestBehavior.DenyGet);
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
                    // Preveri ali država obstaja, če ne jo dodaj // zaenkrat se omejimo samo na Slovenijo (v nadaljne bo potrebno dodati tudi 1 vnosno polje za države)
                    if (!db.Drzava.Any(d => d.imeDrzave == "Slovenia"))
                    {
                        Drzava novaDrzava = new Drzava();
                        novaDrzava.kraticaDrzave = "sl";
                        novaDrzava.imeDrzave = "Slovenia";
                        db.Drzava.Add(novaDrzava);
                        db.SaveChanges();
                        odgovor += "Država vstavljena v db!";
                    }
                    // Preveri ali kraj obstaja, če ne ga dodaj
                    if (!db.Kraj.Any(k => k.nazivKraja == vhod.kraj))
                    {
                        Kraj novKraj = new Kraj();
                        novKraj.nazivKraja = vhod.kraj;
                        novKraj.idKraj = db.Kraj.Max(k=>k.idKraj) + 1;
                        db.Kraj.Add(novKraj);

                        db.SaveChanges();


                        odgovor += "Uspešno dodan kraj" + novKraj.idKraj;

                    }

                    // Ustvari nov naslov 
                    Naslov novNaslov = new Naslov();
                    novNaslov.idNaslov = db.Naslov.Max(n => n.idNaslov) + 1;
                    novNaslov.idKraj = db.Kraj.Where(k => k.nazivKraja == vhod.kraj).Select(k => k.idKraj).Take(1).Single();
                    novNaslov.kraticaDrzave = "sl";
                    novNaslov.hisnaStevilka = vhod.hisnaStevilka;
                    novNaslov.ulica = vhod.ulica;
                    db.Naslov.Add(novNaslov);
                    db.SaveChanges();

                    // Uporabnik spremeni naslov - izbriši starega in mu priredi novo ustvarjenega 
                    // TODO hardcoded: za prvega uporabnika
                    Uporabnik u = db.Uporabnik.Take(1).Single();
                    int idStariNaslov = u.idNaslov;
                    u.idNaslov = novNaslov.idNaslov;
                    Naslov stariNaslov = db.Naslov.Where(n => n.idNaslov == idStariNaslov).Single();
                    db.Naslov.Remove(stariNaslov);
                    db.SaveChanges();

                    // Transakcija uspešno izvedena, commitaj spremembe
                    ts.Complete();

                } catch(Exception ex)
                {
                    var x = 1;
                }
            }
            return Json(odgovor, JsonRequestBehavior.DenyGet);
        }


        // POST UserProfile/PosodobiGeslo
        [HttpPost]
        public JsonResult PosodobiGeslo(GesloVhodniPodatki vhod)
        {

            return Json("hehc he", JsonRequestBehavior.DenyGet);
        }


        // POST UserProfile/PosodobiObnovaRacuna
        [HttpPost]
        public JsonResult PosodobiObnovaRacuna(ObnovaRacunaVhodniPodatki vhod)
        {

            return Json("hehc he", JsonRequestBehavior.DenyGet);
        }


        // POST UserProfile/IzbrisRacuna
        [HttpPost]
        public JsonResult IzbrisRacuna(IzbrisRacunaVhodniPodatki vhod)
        {

            return Json("hehc he", JsonRequestBehavior.DenyGet);
        }
        
       
    }
}