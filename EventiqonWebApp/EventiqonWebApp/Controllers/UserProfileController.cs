using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EventiqonWebApp.Controllers
{
    public class UserProfileController : Controller
    {
        // GET UserProfile or UserProfile/UserPanel
        public ActionResult UserPanel()
        {
            return View();
        }

        // GET UserProfile/UserInbox
        public ActionResult UserInbox()
        {
            return View();
        }
    }
}