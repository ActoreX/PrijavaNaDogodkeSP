$(document).ready(function(){
    $('#datumRojstva').datepicker();
    $('#spremeniOsebnePodatke').click(function(){
         $('#formaOsebniPodatki').submit();
    });
    
    $('#formaOsebniPodatki').validate({
       rules: {
            datumRojstva: {
                date: true
            },
           eposta: {
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
        }
    });
    
    $('#potrdiFormoNaslova').click(function() {
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
               obveznoPolje : true
           },
           kraj: {
               obveznoPolje : true
           }
           
       }
    });
    
    $('#potrdiSpremembeGesla').click(function() {
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
               minlength: 5               
           },
           ponovniVnosGesla: {
               equalTo: "#novoGeslo"
           }
       },
        messages: {
            ponovniVnosGesla: "Gesli se morata ujemati.",
            novoGeslo: {
                minlength: "Geslo mora biti dolgo vsaj 5 znakov"
            },
            staroGeslo: {
                minlength: "Geslo mora biti dolgo vsaj 5 znakov"
            },
            ponovniVnosGesla: "Gesli se morata ujemati.",
        }
    });

jQuery.validator.addMethod("obveznoPolje", $.validator.methods.required, "Polje ne sme biti prazno!");
jQuery.validator.addMethod("veljavnoStevilo", $.validator.methods.number, "Vnesite veljavno število.");

    
jQuery.validator.addMethod("jeTelSt", function(value, element){
    return this.optional(element) || /(^\d{2,3}[-\/]\d{3,4}[-\/]\d{3})$/.test(element.value) || /^\d{9}$/.test(element.value)
}, "Vnesi veljavno tel. številko (npr. xx-xxxx-xxx)")
    
});