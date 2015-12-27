using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EventiqonWebApp.Models
{
    public class AktivnostDogodekVhodniPodatki
    {
        public string vrstaIzbireTrajanja { get; set; }
        public string tipAktEvn { get; set; }
        public string stMestOmejitevAktEvn { get; set; }
        public string datum_od { get; set; }
        public string datum_do { get; set; }
        public string nazivIzbire { get; set; }
        public string vnosLokacije { get; set; }
        public string opisAktEvn { get; set; }
        public string geolocation_lat { get; set; }
        public string geolocation_lon { get; set; }
        public List<PostavkaVhodniPodatki> seznamPostavk { get; set; }
        public int steviloMestSpinner { get; set; }
        public decimal cenaVstopnice { get; set; } 
    }
    public class PostavkaVhodniPodatki
    {
        public string nazivPostavke { get; set; }
        public string casPostavke { get; set; }
        public string casTrajanjaPostavke { get; set; }
        public string opisPostavke { get; set; }
    }

    // Za Google Maps Geolocation
    public class AddressComponent
    {
        public string long_name { get; set; }
        public string short_name { get; set; }
        public List<string> types { get; set; }
    }

    public class Location
    {
        public double lat { get; set; }
        public double lng { get; set; }
    }

    public class Northeast
    {
        public double lat { get; set; }
        public double lng { get; set; }
    }

    public class Southwest
    {
        public double lat { get; set; }
        public double lng { get; set; }
    }

    public class Viewport
    {
        public Northeast northeast { get; set; }
        public Southwest southwest { get; set; }
    }

    public class Bounds
    {
        public Northeast northeast { get; set; }
        public Southwest southwest { get; set; }
    }

    public class Geometry
    {
        public Location location { get; set; }
        public string location_type { get; set; }
        public Viewport viewport { get; set; }
        public Bounds bounds { get; set; }
    }

    public class Result
    {
        public List<AddressComponent> address_components { get; set; }
        public string formatted_address { get; set; }
        public Geometry geometry { get; set; }
        public string place_id { get; set; }
        public List<string> types { get; set; }
    }

    public class GoogleMapsGeocodingModel
    {
        public List<Result> results { get; set; }
        public string status { get; set; }
    }

}