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

        [AllowAnonymous]
        public ActionResult Index()
        {
            var zadnjiDogodki = db.Dogodek.OrderByDescending(d => d.datumVnosa).Take(10);
            return View(zadnjiDogodki);
        }


        [HttpPost]
        public ActionResult Search(SearchInputModel model)
        {

            var rezultatIskanja = new SearchViewModel();
            rezultatIskanja.seznamAktivnosti = new List<Aktivnost>();
            rezultatIskanja.seznamDogodkov = new List<Dogodek>();
            rezultatIskanja.seznamUporabnikov = new List<Uporabnik>();

            if (model.izbiraIskanja == "Aktivnosti" || model.izbiraIskanja == "Vse")
            {
                rezultatIskanja.seznamAktivnosti = db.Aktivnost.OrderByDescending(a => a.datumVnosa).Where(a => (a.naziv.Contains(model.iskalniNiz) || a.nazivLokacije.Contains(model.iskalniNiz)) && (a.datumDo == null || a.datumDo >= DateTime.Now)).Take(10).ToList();
            }
            if (model.izbiraIskanja == "Dogodek" || model.izbiraIskanja == "Vse")
            {
                rezultatIskanja.seznamDogodkov = db.Dogodek.OrderByDescending(d => d.datumVnosa).Where(d => d.datumDo >= DateTime.Now).Take(10).ToList();
            }
            if (model.izbiraIskanja == "Uporabniki" || model.izbiraIskanja == "Vse")
            {
                rezultatIskanja.seznamUporabnikov = db.Uporabnik.Where(u => u.uprabniskoIme.Contains(model.iskalniNiz) || u.email.Contains(model.iskalniNiz)).Take(10).ToList();
            }
            
            return View(rezultatIskanja);
        }

    }
}