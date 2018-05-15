$(document).ready(function(){

    var $form = $('#mc-embedded-subscribe-form');
    if ( $form.length>0) {
        $form.find('input[type="submit"]').bind('click', function (event) {
            if(event) event.preventDefault();
            register($form);
        });
    }

    function register($form){
        $.ajax({
            type: $form.attr('method'),
            url: $form.attr('action'),
            data: $form.serialize(),
            cache: false,
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            error: function(err){ alert("Could not connect to the registration server. Please try again later."); },
            success: function(data){
                if (data.result != "success") {
                    alert('Ops, something went wrong! Have you entered your email correctly?');
                } else {
                    $form.find('input[type="email"]').val('');
                    alert('Your email has been registered. Enjoy! :)');
                }
            }
        });
    }

});
