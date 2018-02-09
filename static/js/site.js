$(document).ready(function() {
    // Following three must be same as in _custom-variables.scss!
    var htmlSizeBase = 21; // (px)
    var fontSizeBase = 1; // (rem)
    var fontScale = 1.414213562373095;
    var maxPostWidth = 540; // (px) Same as $page-content-width!

    function getFontRatio(power) {
        return htmlSizeBase * Math.pow(fontScale, power) * fontSizeBase;
    }

    var introTextWidth = 367.89; // (px) Calculated value of 100% - ((370px / $intro-content-width) * 100%) - 6%;

    $('section, section > div').flowtype({
        minFont: 15,
        maxFont: htmlSizeBase,
        fontRatio: maxPostWidth / htmlSizeBase
    });
    $('.post main').flowtype({
        minFont: 18,
        maxFont: htmlSizeBase,
        fontRatio: maxPostWidth / htmlSizeBase
    });
    $('.intro-text h1').flowtype({
        minFont: getFontRatio(3) / 2,
        maxFont: getFontRatio(3),
        fontRatio: introTextWidth / getFontRatio(3)
    });
    $('.intro-text p').flowtype({
        minFont: 16,
        maxFont: htmlSizeBase,
        fontRatio: introTextWidth / htmlSizeBase
    });
    $('.post-langs').flowtype({
        minFont: 15,
        maxFont: htmlSizeBase,
        fontRatio: maxPostWidth / htmlSizeBase
    });
    $('.subscription-form p').flowtype({
        minFont: getFontRatio(1) / 2,
        maxFont: getFontRatio(1),
        fontRatio: maxPostWidth / getFontRatio(1)
    });
    $('.post h1').flowtype({
        minFont: getFontRatio(4) / 2,
        maxFont: getFontRatio(4),
        fontRatio: 940 / getFontRatio(4) // $post-header-width - $page-padding * 2
    });
    $('.post h2').flowtype({
        minFont: getFontRatio(3) / 2,
        maxFont: getFontRatio(3),
        fontRatio: maxPostWidth / getFontRatio(3)
    });
    $('.post-item h3, .stylish-title, .post h3').flowtype({
        minFont: getFontRatio(2) / 2,
        maxFont: getFontRatio(2),
        fontRatio: maxPostWidth / getFontRatio(2)
    });
    $('.post blockquote p').flowtype({
        minFont: getFontRatio(2) / 2,
        maxFont: getFontRatio(2),
        fontRatio: (maxPostWidth - 66) / getFontRatio(2)
    });

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
                    if ($('html').attr('lang') == 'sv') {
                        alert('Oj, något gick fel! Har du skrivit in din emailadress rätt?');
                    }else{
                        alert('Ops, something went wrong! Have you entered your email correctly?');
                    }
                } else {
                    $form.find('input[type="email"]').val('');
                    if ($('html').attr('lang') == 'sv') {
                        alert('Din email har blivit registrerad. Tack! :)');
                    }else{
                        alert('Your email has been registered. Thank you! :)');
                    }
                }
            }
        });
    }

});
