using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EventiqonWebApp.Models;

namespace EventiqonWebApp.Controllers
{
    public class OrganizerController : Controller
    {
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
            return Json("Super");
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
            return Json("Dela");
        }

        // GET: Organizer/Organizer
        public ActionResult Organizer()
        {
            return View();
        }
    }
}