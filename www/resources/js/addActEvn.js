$(document).ready(function(){
    var omejitevStMest = $("input[name=omejitev-spinner]").spinner();
    omejitevStMest.val("0");
    omejitevStMest.keyup(function(){
        if(isNaN($(this).val())) {
            $(this).val("0");
            alert("Dovoljena so samo števila!");
        }
    })
    omejitevStMest.spinner("option", "min", 0);

    var datumOd = $("input[name=datum-od]").datepicker();
    var datumDo = $("input[name=datum-do]").datepicker();
    
    
    mojaLokacija = new Object();
    mojaLokacija.latitude = 46.057353;
    mojaLokacija.longtitude = 14.504890;

    $('#lokacijaGoogleMaps').locationpicker({
    location: {latitude: mojaLokacija.latitude, longitude: mojaLokacija.longtitude },	 
    radius: 100,
    inputBinding: {
        locationNameInput: $('#vnosLokacije')
    },
    enableAutocomplete: true
    });


    function getLocation() {
        if(navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position){
                console.log(position.coords);
            });
        } else {
            alert("Brskalnik ne podpira geolociranja!")
            return undefined;

        }
    }


    $('#omejitev-spinner').spinner();
    
    var izbiraTrajanja = $('input[name=vrstaIzbireTrajanja]:checked').val();
    nastaviPoljaZaUstreznoIzbiroTrajanja(izbiraTrajanja);
    
    var izbiraTipaCene = $('select[name=tipAktEvn] option:selected').val();
    nastaviPoljaZaUstreznoIzbiroTipa(izbiraTipaCene);
    
    var izbiraOmejitveStMest = $('select[name=stMestOmejitevAktEvn] option:selected').val();
    nastaviPoljaZaUstreznoIzbiroOmejitevStMest(izbiraOmejitveStMest);
    
    $('input[name=vrstaIzbireTrajanja]').change(function(param){
        //console.log(param.currentTarget.value); 
        nastaviPoljaZaUstreznoIzbiroTrajanja(param.currentTarget.value);
            
    });
    $('select[name=tipAktEvn]').change(function(param){
        console.log(param.currentTarget.value); 
        nastaviPoljaZaUstreznoIzbiroTipa(param.currentTarget.value);        
            
    });  
    
    $('select[name=stMestOmejitevAktEvn]').change(function(param){
        console.log(param.currentTarget.value); 
        nastaviPoljaZaUstreznoIzbiroOmejitevStMest(param.currentTarget.value)
            
    });
    
    
    
    function nastaviPoljaZaUstreznoIzbiroTrajanja(trajanje) {
        var datumDo = $('input[name=datum-do]');
        if(trajanje == "enkratna") {
            datumDo.val("");
            datumDo.prop("disabled", false);
        } else if(trajanje == "ponavljajoca") {
            datumDo.val("/");
            datumDo.prop("disabled", true);
        } else {
            alert("nastaviPoljaZaUsteznoIzbiroTrajanja parameter ni veljaven!");
        }
    }
    
    function nastaviPoljaZaUstreznoIzbiroTipa(tip) {
        var cenaVstopnice = $('input[name=cenaVstopnice]');
        if(tip == "brezplacna") {
            cenaVstopnice.val("0");
            cenaVstopnice.prop("disabled", true);
            
        } else if (tip == "placljiva") {
            cenaVstopnice.prop("disabled", false);
        } else {
            alert("nastaviPoljaZaUstreznoIzbiroTipa paramtere ni veljaven!");
        }
    }
    
    function nastaviPoljaZaUstreznoIzbiroOmejitevStMest(omejitev) {
        var steviloMestSpinner = $("input[name=omejitev-spinner]").spinner();

        if(omejitev == "neomejeno") {
            steviloMestSpinner.val("inf");  
            steviloMestSpinner.spinner("disable");
            
        } else if (omejitev == "omejeno") {
            steviloMestSpinner.val(0);
            steviloMestSpinner.spinner("enable");
        } else {
            alert("nastaviPoljaZaUstreznoIzbiroTipa paramtere ni veljaven!");
        }
    }

    
    steviloPostavk = 1;
    $('#dodajNovoPostavko').click(function(){
        steviloPostavk = steviloPostavk + 1;
        $('.postavkaAktEvn tr:last').after(
                                        "<tr class='postavka-"+steviloPostavk +"'>" +                                                 
                                            "<td>" +
                                                "<input name='nazivPostavke"+ steviloPostavk +"' class='nazivPostavke' type='text' placeholder='Naziv postavke #"+ steviloPostavk +"'>"+
                                           "</td>" +                                                 
                                           "<td>" +
                                                "<input name='casPostavke"+ steviloPostavk +"' class='casPostavke' style='width:95%; margin-left:2.5%;' type='text' placeholder='Dan v tednu ali datum'></td>"  +                                               
                                            "<td>" +
                                                "<input name='casTrajanjaPostavke"+ steviloPostavk +"' class='casTrajanjaPostavke' type='text' placeholder='Čas trajanja'>" +
                                           "</td>" +                                            
                                        "</tr>" +                                            
                                        "<tr class='postavka-"+steviloPostavk +"'>" +                                                
                                           "<td colspan='3'>" +                                                     
                                                "<textarea name='opisPostavke"+ steviloPostavk +"' class='opisPostavke'></textarea>" +
                                           "</td>" +
                                        "</tr>");
        
    });
    
    $('#odstraniZadnjoPostavko').click(function(){
        if(steviloPostavk == 1) {
            alert("Postavke #1 ni mozno izbrisati!");
            return;
        }
        $('.postavka-' + steviloPostavk).remove();
        steviloPostavk = steviloPostavk - 1;
         
    });
    
    
    
    var vnosnaFormaAktEvn = $('#vnosnaFormaAktEvn').validate({
       rules: {
           nazivIzbire: {
               required: true
           },
           cenaVstopnice: {
               veljavnaCena:  {tipAktEvn: $('select[name=tipAktEvn]')}
           },
           "datum-do" : {
               veljavnoTrajanje: {vrstaTrajanja: $('input[name=vrstaIzbireTrajanja]:checked'),
                                 datumOd: $('#datum-od')}
           },
           "datum-od": {
               required: true
           },
           opisAktEvn: {
               required: true
           }
        },
        messages: {
            nazivIzbire: "Polje ne sme biti prazno!",
            opisAktEvn: "Polje ne sme biti prazno!",
            "datum-od": "Polje ne sme biti prazno!",
            nazivPostavke: "Polje ne sme biti prazno!"
        }
        
    }); 
    
jQuery.validator.addClassRules('nazivPostavke', {
    obveznoPolje: true
});

jQuery.validator.addClassRules('casPostavke', {
    obveznoPolje: true
});
    
jQuery.validator.addClassRules('casTrajanjaPostavke', {
    obveznoPolje: true
});
    
jQuery.validator.addClassRules('opisPostavke', {
    obveznoPolje: true
});
    
    
    $('#potrdiFormoAktEvn').click(function(){
         $('#vnosnaFormaAktEvn').submit();
    });
    
    
});



jQuery.validator.addMethod("obveznoPolje", $.validator.methods.required, "Polje ne sme biti prazno!");

jQuery.validator.addMethod("veljavnaCena", function(value, element, options) {
    return options.tipAktEvn.val() == "placljiva" && value > 0
}, "V primeru plačljivega tipa, morate podati veljavno ceno (n>0)!");

jQuery.validator.addMethod("veljavnoTrajanje", function(value, element, options) {
    return options.vrstaTrajanja.val() == "enkratna" && /^\d{2}\/\d{2}\/\d{4}$/.test(element.value) && /^\d{2}\/\d{2}\/\d{4}$/.test(options.datumOd.val()) && options.datumOd.val() <= element.value
}, "Datum mora biti >= od začetka, če je izbrana vrsta enkratno");

