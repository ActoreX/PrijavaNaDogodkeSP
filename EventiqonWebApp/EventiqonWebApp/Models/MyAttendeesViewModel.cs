﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EventiqonWebApp.Models
{
    public class MyAttendeesViewModel
    {
        public IEnumerable<SeznamAktivnosti> seznamAktivnosti { get; set; }
        public IEnumerable<SeznamDogodkov> seznamDogodkov { get; set; }
    }
}