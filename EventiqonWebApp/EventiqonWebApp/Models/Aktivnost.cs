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
    
    public partial class Aktivnost
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Aktivnost()
        {
            this.PostavkaAktivnosti = new HashSet<PostavkaAktivnosti>();
            this.SeznamAktivnosti = new HashSet<SeznamAktivnosti>();
        }
    
        public int idAktivnost { get; set; }
        public int idKraj { get; set; }
        public string kraticaDrzave { get; set; }
        public Nullable<int> omejitevMest { get; set; }
        public System.DateTime datumVnosa { get; set; }
        public System.DateTime datumOd { get; set; }
        public Nullable<System.DateTime> datumDo { get; set; }
        public bool jeEnkratna { get; set; }
        public double latitude { get; set; }
        public double longitude { get; set; }
        public string nazivLokacije { get; set; }
        public string opis { get; set; }
        public decimal cena { get; set; }
    
        public virtual Drzava Drzava { get; set; }
        public virtual Kraj Kraj { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PostavkaAktivnosti> PostavkaAktivnosti { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<SeznamAktivnosti> SeznamAktivnosti { get; set; }
    }
}
