//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace EventiqonWebApp.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class SeznamAktivnosti
    {
        public string uprabniskoIme { get; set; }
        public int idAktivnost { get; set; }
        public int idSeznamAktivnosti { get; set; }
        public string statusUdelezbe { get; set; }
        public Nullable<decimal> cena { get; set; }
    
        public virtual Aktivnost Aktivnost { get; set; }
        public virtual Uporabnik Uporabnik { get; set; }
    }
}
