$(document).ready(function(){
    var omejitevStMest = $("input[name=omejitev-spinner]").spinner();
    omejitevStMest.val("100");
    omejitevStMest.spinner("option", "min", 0);
    omejitevStMest.spinner("option", "max", 500);

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
    
    var jeEnkratna = $('input[name=vrstaIzbireTrajanja]:checked').val();
    nastaviPoljaZaUstreznoIzbiroTrajanja(jeEnkratna);
    
    var jeBrezplacna = $('select[name=tipAktEvn] option:selected').val();
    nastaviPoljaZaUstreznoIzbiroTipa(jeBrezplacna);
    
    var jeOmejenoStMest = $('select[name=stMestOmejitevAktEvn] option:selected').val();
    nastaviPoljaZaUstreznoIzbiroOmejitevStMest(jeOmejenoStMest);
    
    $('input[name=vrstaIzbireTrajanja]').change(function(param){
        //console.log(param.currentTarget.value); 
        nastaviPoljaZaUstreznoIzbiroTrajanja(param.currentTarget.value)
            
    });
    $('select[name=tipAktEvn]').change(function(param){
        console.log(param.currentTarget.value); 
        nastaviPoljaZaUstreznoIzbiroTipa(param.currentTarget.value)
            
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
            steviloMestSpinner.val(100);
            steviloMestSpinner.spinner("enable");
        } else {
            alert("nastaviPoljaZaUstreznoIzbiroTipa paramtere ni veljaven!");
        }
    }
    
    $('.novaAktEvn').validate({
       rules: {
           nazivIzbire: "required"
       },
        messages: {
            nazivIzbire: "Bla"
        }
        
    });
    
});

