using EventiqonWebApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
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

        // POST UserProfile/UserPanel/PosodobiNaslov
        [HttpPost]
        public JsonResult PosodobiNaslov()
        {
            string jsonString;
            using (var reader = new System.IO.StreamReader(Request.InputStream))
            {
                jsonString = reader.ReadToEnd();
            }
            Dictionary<string, string> vhodniPodatki  = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, string>>(jsonString);
            

            return Json("hehc he", JsonRequestBehavior.DenyGet);
        }
    }
}