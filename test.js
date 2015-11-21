$(document).ready(function () {

    $('#myform').validate({ 
        rules: {
            field1: {
                required: true,
                email: true
            },
            field2: {
                required: true,
                minlength: 5
            }
       
        },
         messages: {
            field1: "Vnos",
            field2: "hahah",
        }
    });

});