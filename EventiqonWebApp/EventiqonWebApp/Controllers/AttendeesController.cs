using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EventiqonWebApp.Models;

namespace EventiqonWebApp.Controllers
{
    public class AttendeesController : Controller
    {

        EventiqonEntities db = new EventiqonEntities();

        // GET: Attendees/MyAttendees
        public ActionResult MyAttendees()
        {
            Uporabnik u = db.Uporabnik.Take(1).Single();

            MyAttendeesViewModel mavm = new MyAttendeesViewModel();
            mavm.seznamAktivnosti = db.SeznamAktivnosti.Where(a => a.uprabniskoIme == u.uprabniskoIme).Take(10);
            mavm.seznamDogodkov = db.SeznamDogodkov.Where(d => d.uprabniskoIme == u.uprabniskoIme).Take(10);
            
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
            Uporabnik u = db.Uporabnik.First();

            // morda popravi,    da je status udeležbe določene vrednosti (npr. pridem)
            mavm.seznamAktivnosti = db.SeznamAktivnosti.Where(a => vhod.datumOd <= a.Aktivnost.datumOd && (a.Aktivnost.datumDo == null || vhod.datumDo >= a.Aktivnost.datumDo) && a.uprabniskoIme == u.uprabniskoIme);
            mavm.seznamDogodkov = db.SeznamDogodkov.Where(d => vhod.datumOd <= d.Dogodek.datumOd && vhod.datumDo >= d.Dogodek.datumDo && d.uprabniskoIme == u.uprabniskoIme);

            return PartialView(mavm);
        }

        
    }
}   