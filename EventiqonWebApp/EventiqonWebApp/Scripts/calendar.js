$(document).ready(function(){
    
    // http://stackoverflow.com/questions/16092288/date-range-picker-on-jquery-ui-datepicker
    $('#koledar').datepicker({
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
                data = {};
                var datumOd = new Date($('#input1').val());
                var datumDo = new Date($('#input2').val());

                data["datumOd"] = datumOd.getDate() + "-" + (datumOd.getMonth()+1) + "-" + datumOd.getFullYear();
                data["datumDo"] = datumDo.getDate() + "-" + (datumDo.getMonth()+1) + "-" + datumDo.getFullYear();
              
                $.ajax({
                    url: "/Attendees/PostavkeKoledarja",
                    data: data,
                    type: "POST",
                    dataType: "html",
                    success: function (result) {
                        console.log(result);
                    }
                });

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

