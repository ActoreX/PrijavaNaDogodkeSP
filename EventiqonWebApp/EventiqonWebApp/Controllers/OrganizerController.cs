using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EventiqonWebApp.Models;
using System.Net.Http;
using RestSharp;

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
            // GET: (klic Google Maps APIja za geodecoding
            // https://maps.googleapis.com/maps/api/geocode/json?latlng=46.06813252000273,14.544028793945245&key=AIzaSyAmZRoA4MHaKQDY4JuWnkV3ZB-k69kluts
        
            var restClient = new RestClient("https://maps.googleapis.com");
            var request = new RestRequest(Method.GET);
            request.Resource = "maps/api/geocode/json";
            request.AddParameter("latlng", "46.06813252000273,14.544028793945245");
            request.AddParameter("key", "AIzaSyAmZRoA4MHaKQDY4JuWnkV3ZB-k69kluts");
        
            var response = restClient.Execute<GoogleMapsGeocodingModel>(request);

            GoogleMapsGeocodingModel googleMapsModel = response.Data;

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