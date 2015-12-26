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
        public List<PostavkaVhodniPodatki> seznamPostavk { get; set; }
         
    }
    public class PostavkaVhodniPodatki
    {
        public string nazivPostavke { get; set; }
        public string casPostavke { get; set; }
        public string casTrajanjaPostavke { get; set; }
        public string opisPostavke { get; set; }
    }
}