$(document).ready(function(){
    
    // http://stackoverflow.com/questions/16092288/date-range-picker-on-jquery-ui-datepicker
    $('#koledar').datepicker({
			minDate: 0,
			beforeShowDay: function(date) {
				var date1 = $.datepicker.parseDate($.datepicker._defaults.dateFormat, $("#input1").val());
				var date2 = $.datepicker.parseDate($.datepicker._defaults.dateFormat, $("#input2").val());
				return [true, date1 && ((date.getTime() == date1.getTime()) || (date2 && date >= date1 && date <= date2)) ? "dp-highlight" : ""];
			},
            onSelect: function(dateText, inst) {
                var date1 = $.datepicker.parseDate($.datepicker._defaults.dateFormat, $("#input1").val());
                var date2 = $.datepicker.parseDate($.datepicker._defaults.dateFormat, $("#input2").val());
                var selectedDate = $.datepicker.parseDate($.datepicker._defaults.dateFormat, dateText);

                if (!date1 || date2) {
                    $("#input1").val(dateText);
                    $("#input2").val("");
                    $(this).datepicker();
                } else if( selectedDate < date1 ) {
                    $("#input2").val( $("#input1").val() );
                    $("#input1").val( dateText );
                    $(this).datepicker();
                } else {
                    $("#input2").val(dateText);
                    $(this).datepicker();
                }
            }
		});
        
        $('#isci').click(function(){
            if(intervalIzbran()) {
                // pridobi podatke
                // ko imas podatke pridobljene, prikazi rezultat
                $('#rezultatIskanja').show("slide", {direction: "right"}, 500);
            }
        });
    
        $('#izvozi').click(function(){
            alert("Logika za izvoz podatkov");
        });
    
        function intervalIzbran(){
            return ($('#input1').val() != "" && $('#input2').val() != "")
        }
});

