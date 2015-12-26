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
    }
}