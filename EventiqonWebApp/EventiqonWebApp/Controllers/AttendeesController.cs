using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EventiqonWebApp.Controllers
{
    public class AttendeesController : Controller
    {
        // GET: Attendees/MyAttendees
        public ActionResult MyAttendees()
        {
            return View();
        }

        // GET: Attendees/Calendar
        public ActionResult Calendar()
        {
            return View();
        }
    }
}