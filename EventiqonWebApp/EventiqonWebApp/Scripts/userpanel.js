$(document).ready(function () {
    $('body').scrollspy({ target: '#scrollSpyNavigation' })

    $('#datumRojstva').datepicker();


    $('#potrdiFormoNaslova').click(function () {
        $('#formaNaslova').submit();
    });


    $('#formaNaslova').validate({
        rules: {
            ulica: {
                obveznoPolje: true
            },
            postnaStevilka: {
                obveznoPolje: true,
                veljavnoStevilo: true
            },
            hisnaStevilka: {
                obveznoPolje: true
            },
            kraj: {
                obveznoPolje: true
            }

        },

        submitHandler: function (form) {
            //var testdata = {
            //    ulica: "Ulica 1",
            //    hisnaStevilka: "100",
            //    postnaStevilka: "1000",
            //    kraj: "Ljubljana"
            //}

            var mydata = $('#formaNaslova').serializeArray();
            console.log(mydata);
            // Pozor!!! Pri pošiljanju morajo biti podatki obvezno v objektu z istimi lastnostmi kot model
            // ne uporabljaj funkcije JSON.stringify !!!
            $.ajax({
                url: "/UserProfile/PosodobiNaslov",
                data: mydata,
                type: "POST",
                dataType: "json",
                success: function (result) {
                    console.log(result);
                }
            });
        },
    });

    $('#spremeniOsebnePodatke').click(function(){
         $('#formaOsebniPodatki').submit();
    });
    
    $('#formaOsebniPodatki').validate({
       rules: {
            datumRojstva: {
                date: true
            },
            eposta: {
               obveznoPolje: true,
               email: true
            },
            telSt: {
                jeTelSt : true
            },
            paypalRacun: {
                email : true
            }
       },
        messages: {
            datumRojstva: "Vnesite veljaven datum (MM/dd/yyyy)",
            eposta: "Vnesi veljaven e-naslov",
            paypalRacun: "Vnesi polni Paypal račun(e-naslov)"
        },
        submitHandler: function (form) {
            var mydata = $('#formaOsebniPodatki').serializeArray();
            console.log(mydata);
            $.ajax({
                url: "/UserProfile/PosodobiOsebniPodatki",
                data: mydata,
                type: "POST",
                dataType: "json",
                success: function (result) {
                    console.log(result);
                }
            });
        },
    });
    
    
    $('#potrdiSprememboGesla').click(function() {
        $('#formaSpremeniGeslo').submit();    
    });
    
    $('#formaSpremeniGeslo').validate({
       rules: {
            staroGeslo: {
                obveznoPolje: true,
                minlength: 5
            },
           novoGeslo: {
               obveznoPolje: true,
               minlength: 5,
               niEnako: {drugElement:'#staroGeslo'}
           },
           ponovniVnosGesla: {
               obveznoPolje: true,
               equalTo: "#novoGeslo"
           }
       },
        messages: {
            ponovniVnosGesla: "Gesli se morata ujemati",
            novoGeslo: {
                minlength: "Geslo mora biti dolgo vsaj 5 znakov"
            },
            staroGeslo: {
                minlength: "Geslo mora biti dolgo vsaj 5 znakov"
            },
            ponovniVnosGesla: "Gesli se morata ujemati",
        },
        submitHandler: function (form) {
            var mydata = $('#formaSpremeniGeslo').serializeArray();
            console.log(mydata);
            $.ajax({
                url: "/UserProfile/PosodobiGeslo",
                data: mydata,
                type: "POST",
                dataType: "json",
                success: function (result) {
                    console.log(result);
                }
            });
        },
    });
   
    $('#potrdiFormoObnoveRacuna').click(function() {
        $('#formaObnoveRacuna').submit();    
    });
    
    $('#formaObnoveRacuna').validate({
       rules: {
            pomozniEmail: {
                obveznoPolje: true,
                email: true
            },
           ponovniVnosPomoznegaEmaila: {
               obveznoPolje: true,
               equalTo: "#pomozniEmail"
           },
           telStZaObnovitev: {
               obveznoPolje: true,
               jeTelSt: true
           }
       },
        messages: {
            pomozniEmail: {
                email: "Vnesi veljaven e-naslov"
            },
            ponovniVnosPomoznegaEmaila: {
                email: "Vnesi veljaven e-naslov",
                equalTo: "Polji se morata ujemati"
            }
       },
        submitHandler: function (form) {
        var mydata = $('#formaObnoveRacuna').serializeArray();
        console.log(mydata);
        $.ajax({
            url: "/UserProfile/PosodobiObnovaRacuna",
            data: mydata,
            type: "POST",
            dataType: "json",
            success: function (result) {
                console.log(result);
            }
        });
    },
    });
    
    $('#potrdiIzbrisRacuna').click(function() {
        $('#formaIzbrisRacuna').submit();    
    });
    
    $('#formaIzbrisRacuna').validate({
       rules: {
            izbrisUpIme: {
                obveznoPolje: true,
                equalTo: "#uporabniskoIme"
            },
           izbrisGeslo: {
               obveznoPolje: true
           }
       },
        messages: {
            pomozniEmail: {
                email: "Vnesi veljaven e-naslov"
            },
            izbrisUpIme: "Vnesi svoje uporabniško ime",
            izbrisGeslo: "Vnesi svoje geslo"

        },
        submitHandler: function (form) {
            var mydata = $('#formaIzbrisRacuna').serializeArray();
            console.log(mydata);
            $.ajax({
                url: "/UserProfile/IzbrisRacuna",
                data: mydata,
                type: "POST",
                dataType: "json",
                success: function (result) {
                    console.log(result);
                }
            });
        },
    });

   
jQuery.validator.addMethod("obveznoPolje", $.validator.methods.required, "Polje ne sme biti prazno!");
jQuery.validator.addMethod("veljavnoStevilo", $.validator.methods.number, "Vnesite veljavno število.");

    
jQuery.validator.addMethod("jeTelSt", function(value, element){
    return this.optional(element) || /(^\d{2,3}[-\/]\d{3,4}[-\/]\d{3})$/.test(element.value) || /^\d{9}$/.test(element.value)
}, "Vnesi veljavno tel. številko (npr. xx-xxxx-xxx)")

jQuery.validator.addMethod("niEnako", function(value, element, options){
    return $(options.drugElement).val() !== element.value
}, "Polje ne sme biti enako")
    
});
