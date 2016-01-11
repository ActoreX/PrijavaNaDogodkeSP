using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EventiqonWebApp.Models;
using System.Security.Claims;


namespace EventiqonWebApp.Controllers
{
    public class AttendeesController : Controller
    {

        EventiqonEntities db = new EventiqonEntities();

        // GET: Attendees/MyAttendees
        public ActionResult MyAttendees()
        {
            //Uporabnik u = db.Uporabnik.Take(1).Single();
            var claimsIdentity = User.Identity as ClaimsIdentity;
            var upIme = claimsIdentity.FindFirst(ClaimTypes.GivenName).Value;
                 
            MyAttendeesViewModel mavm = new MyAttendeesViewModel();
            mavm.seznamAktivnosti = db.SeznamAktivnosti.Where(a => a.uprabniskoIme == upIme).Take(10);
            mavm.seznamDogodkov = db.SeznamDogodkov.Where(d => d.uprabniskoIme == upIme).Take(10);
            
            return View(mavm);
        }

        // GET: Attendees/Calendar
        public ActionResult Calendar()
        { 
            return View();
        }

        // POST: Attendees/PostavkeKoledarja
        [HttpPost]
        public ActionResult PostavkeKoledarja(KoledarVhodniPodatki vhod)
        {
            MyAttendeesViewModel mavm = new MyAttendeesViewModel();
            //Uporabnik u = db.Uporabnik.First();

            var claimsIdentity = User.Identity as ClaimsIdentity;
            var upIme = claimsIdentity.FindFirst(ClaimTypes.GivenName).Value;

            // morda popravi,    da je status udeležbe določene vrednosti (npr. pridem)
            mavm.seznamAktivnosti = db.SeznamAktivnosti.Where(a => (a.Aktivnost.datumDo == null && !(vhod.datumDo < a.Aktivnost.datumOd) || a.Aktivnost.datumDo != null && !(vhod.datumDo < a.Aktivnost.datumOd) && !(vhod.datumOd > a.Aktivnost.datumDo)) && a.uprabniskoIme == upIme);
            mavm.seznamDogodkov = db.SeznamDogodkov.Where(d => !(vhod.datumDo < d.Dogodek.datumOd) && !(vhod.datumOd > d.Dogodek.datumDo) && d.uprabniskoIme == upIme);

            return PartialView(mavm);
        }

        
    }
}   