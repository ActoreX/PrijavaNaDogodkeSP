using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EventiqonWebApp.Models;
namespace EventiqonWebApp.Controllers
{
    public class HomeController : Controller
    {

        EventiqonEntities db = new EventiqonEntities();


        public ActionResult Index()
        {
            var zadnjiDogodki = db.Dogodek.OrderByDescending(d => d.datumVnosa).Take(10);
            return View(zadnjiDogodki);
        }

    }
}