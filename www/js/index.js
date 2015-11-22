$(document).ready(function(){
    $('.showMapIcon').tooltip();
    
    $('.showMapIcon').click(function(element){
        var cilj = element.currentTarget.alt;
        var mapaSkrita = $('#'+cilj).css("display") == 'none';
        if(mapaSkrita) {
            $(this).attr("data-original-title", "Skrij mapo");
            mapaSkrita = false;
        }
        else {
            $(this).attr("data-original-title", "Prikaži mapo");
            mapaSkrita = true;
        }
        $('#'+cilj).slideToggle("slow");
        
    });
    
    $('.env-follow, .env-unfollow').click(function(){
        if($(this).hasClass("env-follow") == true){
            $(this).addClass("env-unfollow").removeClass("env-follow");
            $(this).addClass("btn-warning").removeClass("btn-info");    
            $(this).val("Ne sledi");
        } else {    
            $(this).addClass("env-follow").removeClass("env-unfollow")
            $(this).addClass("btn-info").removeClass("btn-warning");
            $(this).val("Sledi");
        }
        
    });   
    
    
    $('.env-attend, .env-cancel').click(function(){
        if($(this).hasClass("env-attend") == true){
            $(this).addClass("env-cancel").removeClass("env-attend");
            $(this).addClass("btn-danger").removeClass("btn-success"); 
            $(this).val("Prekliči udeležbo");
        } else {    
            $(this).addClass("env-attend").removeClass("env-cancel")
            $(this).addClass("btn-success").removeClass("btn-danger");
          $(this).val("Potrdi udeležbo");
        }
        
    }); 
     
        
});