$(document).ready(function () {
    nastaviNavigacijo();
});


// dodajanje aktivne izbire menija glede na URL
function nastaviNavigacijo() {
    var pot = location.href.replace(/(.+)(\/\/[\w.\d:]+)(.+)/, "$3")
    $("header a").each(function () {
        var povezavaElementa = $(this).attr("href");
        if (povezavaElementa == pot) {
            var $aktivenElement = $(this).parent("li");
            // Otroku dodamo razred active
            $aktivenElement.addClass("active");
            // Tudi staršu (če ga ima) dodamo razred active
            $aktivenElement.parents("li").addClass("active");   
        }
    });

}

