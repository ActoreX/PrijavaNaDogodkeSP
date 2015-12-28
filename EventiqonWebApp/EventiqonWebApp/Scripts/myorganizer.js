$(document).ready(function () {
    $('body').scrollspy({ target: '#scrollSpyNavigation' });
    $('.spremeniAkt, .spremeniDog').click(function () {
        console.log($(this).context.className);
        var gumb = $(this);
        var novStatus = $(this).context.textContent;
        // Če je končano, ne sproži ajax zahtevka
        if (novStatus == "Končano" || confirm("Ali ste prepričani, da želite zaključiti izbrano prireditev? Nadaljne spremembe ne bodo več možne! ") == false) {
            return;
        }
        var actionInfo = $(this).context.name.split("_");
    

        var data = {
            statusUdelezbe: novStatus,
            idAktivnosti: (actionInfo[0]=="akt")? actionInfo[1] : -1,
            idDogodka: (actionInfo[0] == "dog") ? actionInfo[1] : -1,
        };

        $.ajax({
            url: "/Organizer/SpremeniStatusUdelezbe",
            data: data,
            type: "POST",
            dataType: "json",
            success: function (result) {
                console.log(result);
                if (result == "OK") {
                    console.log(gumb);
                    gumb.text("Končano");
                }
            }
        });
       

        console.log(data);
    });

});