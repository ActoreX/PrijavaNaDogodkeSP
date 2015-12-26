using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

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
        public JsonResult AddNewActivity(EventiqonWebApp.Models.AktivnostDogodekVhodniPodatki vhod)
        {
            return Json("Super");
        }

        // GET: Organizer/AddNewEvent
        public ActionResult AddNewEvent()
        {
            return View();
        }

        // GET: Organizer/Organizer
        public ActionResult Organizer()
        {
            return View();
        }
    }
}