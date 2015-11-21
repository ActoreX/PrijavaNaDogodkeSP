$(document).ready(function(){
    $("input[name=omejitev-spinner]").spinner();
    $("input[name=omejitev-spinner]").spinner().val("100");
    $("input[name=omejitev-spinner]").spinner("option", "min", 0);
    $("input[name=omejitev-spinner]").spinner("option", "max", 500);

    $("input[name=datum-od]").datepicker();
    $("input[name=datum-do]").datepicker();

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

});