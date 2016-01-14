using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EventiqonWebApp.Models
{
    public class SearchInputModel
    {
        public bool vMojiBlizini { get; set; }
        public bool samoNovo { get; set; }
        public string izbiraIskanja { get; set; }
        public string iskalniNiz { get; set; }
    }

    public class SearchViewModel
    {
        public List<Aktivnost> seznamAktivnosti { get; set; }
        public List<Dogodek> seznamDogodkov { get; set; }
        public List<Uporabnik> seznamUporabnikov { get; set; }

    }
}