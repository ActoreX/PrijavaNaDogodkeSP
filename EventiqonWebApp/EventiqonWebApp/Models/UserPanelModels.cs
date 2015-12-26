using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EventiqonWebApp.Models
{
    public class NaslovVhodniPodatki
    {
        public string ulica { get; set; }
        public int hisnaStevilka { get; set; }
        public int postnaStevilka { get; set; }
        public string kraj { get; set; }
    }

    public class OsebniPodatkiVhodniPodatki
    {
        public string eposta { get; set; }
        public DateTime datumRojstva { get; set; }
        public string telSt { get; set; }
        public string paypalRacun { get; set; }
    }

    public class GesloVhodniPodatki
    {
        public string staroGeslo { get; set; }
        public string novoGeslo { get; set; }
        public string ponovniVnosGesla { get; set; }
    }

    public class ObnovaRacunaVhodniPodatki
    {
        public string pomozniEmail { get; set; }
        public string ponovniVnosPomoznegaEmaila { get; set; }
        public string telStZaObnovitev { get; set; }
    }

    public class IzbrisRacunaVhodniPodatki
    {
        public string izbrisUpIme { get; set; }
        public string izbrisGeslo { get; set; }
        public string izbrisRazlog { get; set; }
    }

   

}