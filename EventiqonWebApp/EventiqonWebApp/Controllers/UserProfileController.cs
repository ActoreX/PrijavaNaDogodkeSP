using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using EventiqonWebApp.Models;
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
    }
}