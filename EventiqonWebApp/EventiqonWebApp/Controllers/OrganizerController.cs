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
        public ActionResult AddNewActivity()
        {
            return View();
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