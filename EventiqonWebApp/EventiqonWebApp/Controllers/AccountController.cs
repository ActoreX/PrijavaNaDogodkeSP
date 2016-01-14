using System;
using System.Globalization;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using EventiqonWebApp.Models;

namespace EventiqonWebApp.Controllers
{

    [Authorize]
    public class AccountController : Controller
    {

        // kontekst moje podatkovne baze
        EventiqonEntities db = new EventiqonEntities();

       
        //
        // GET: /Account/Login
        [AllowAnonymous]
        [OutputCache(CacheProfile = "CacheFor1Hour")]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        //
        // POST: /Account/Login
        [HttpPost]
        [AllowAnonymous]
        public ActionResult Login(CustomLoginViewModel model, string returnUrl)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            // preveri, ali so vnešeni podatki v bazi
            if(db.Uporabnik.Any(u=>u.uprabniskoIme == model.upIme && u.geslo == model.geslo && u.status != "izbrisan"))
            {
                Uporabnik up = db.Uporabnik.Where(u => u.uprabniskoIme == model.upIme && u.geslo == model.geslo).Single();
                var identity = new ClaimsIdentity(new[] {
                    new Claim(ClaimTypes.GivenName, up.uprabniskoIme),
                    new Claim(ClaimTypes.Email, up.email)
                },
                "EventiqonApplicationCookie");

                var ctx = Request.GetOwinContext();
                var authManager = ctx.Authentication;

                authManager.SignIn(identity);

                return RedirectToLocal(returnUrl);

            }

            ModelState.AddModelError("", "Neveljavno uporabniško ime ali geslo!");
            return View();
        }

      
        //
        // GET: /Account/Register
        [AllowAnonymous]
        [OutputCache(CacheProfile = "CacheFor1Hour")]
        public ActionResult Register()
        {
            return View();
        }

        //
        // POST: /Account/Register
        [HttpPost]
        [AllowAnonymous]
        public ActionResult Register(CustomRegisterViewModel model)
        {
            if (ModelState.IsValid)
            {
                // probaj vstaviti novega uporabnika
                Uporabnik novUp = new Uporabnik();
                novUp.uprabniskoIme = model.upIme;
                novUp.email = model.eposta;
                novUp.geslo = model.geslo;
                novUp.status = "potrjen";
                novUp.idNaslov = 26; // v bazi sem ustvaril 26 zapis naslova, ki ima vsa polja nastavljena na neznano vrednost (/ oz. 0)

                try
                {
                    db.Uporabnik.Add(novUp);
                    db.SaveChanges();

                    // uporabnik uspešno ustvarjen
                    var identity = new ClaimsIdentity(new[] {
                        new Claim(ClaimTypes.GivenName, novUp.uprabniskoIme),
                        new Claim(ClaimTypes.Email, novUp.email)
                    },
                    "EventiqonApplicationCookie");

                    Obvestilo o = new Obvestilo();
                    o.datum = DateTime.Now;
                    o.tema = "Dobrodošli na portalu - Eventiqon!";
                    o.sporocilo = "2Y7Y133LXBLTIEXT6MC0YY8TEHN2CDJMI40RVEL9EDCF7TJ4AOJ8SXY7NNLIDH6KN4EIH 2Y7Y133LXBLTIEXT6MC0YY8TEHN2CDJMI40RVEL9EDCF7TJ4AOJ8SXY7NNLIDH6KN4EIH 2Y7Y133LXBLTIEXT6MC0YY8TEHN2CDJMI40RVEL9EDCF7TJ4AOJ8SXY7NNLIDH6KN4EIH";
                    o.idObvestilo = db.Obvestilo.Max(x => x.idObvestilo) + 1;
                    o.uprabniskoIme = novUp.uprabniskoIme;
                    db.Obvestilo.Add(o);
                    db.SaveChanges();

                    var ctx = Request.GetOwinContext();
                    var authManager = ctx.Authentication;
                    authManager.SignIn(identity);

                    return RedirectToAction("Index", "Home");


                } catch (Exception e)
                {
                    // poskrbi za napako
                    Console.Write(e.Message);
                    ModelState.AddModelError("", "Prišlo je do napake pri ustvarjanju računa - " + e.Message);
                }
                
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }


        //
        // /Account/LogOff
        public ActionResult LogOff()
        {
            var ctx = Request.GetOwinContext();
            var authManager = ctx.Authentication;

            authManager.SignOut("EventiqonApplicationCookie");
            return RedirectToAction("Index", "Home");
        }

      

        #region Helpers

        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }

        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            return RedirectToAction("Index", "Home");
        }

        internal class ChallengeResult : HttpUnauthorizedResult
        {
            public ChallengeResult(string provider, string redirectUri)
                : this(provider, redirectUri, null)
            {
            }

            public ChallengeResult(string provider, string redirectUri, string userId)
            {
                LoginProvider = provider;
                RedirectUri = redirectUri;
                UserId = userId;
            }

            public string LoginProvider { get; set; }
            public string RedirectUri { get; set; }
            public string UserId { get; set; }
        }
        #endregion
    }
}