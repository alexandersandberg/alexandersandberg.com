$(document).ready(function() {
    var initialHeaderWidth = parseInt($('header').css('max-width')) - parseInt($('header').css('padding-left')) - parseInt($('header').css('padding-right'));

    var contentContainer = 'main';
    var initialPageWidth = parseInt($(contentContainer).css('max-width')) - parseInt($(contentContainer).css('padding-left')) - parseInt($(contentContainer).css('padding-right'));

    // Following three must be same as in _custom-variables.scss!
    var htmlSizeBase = 20; // (px)
    var fontSizeBase = 1; // (rem)
    var fontScale = 1.414213562373095;

    function getFontRatio(power) {
        return htmlSizeBase * Math.pow(fontScale, power) * fontSizeBase;
    }

    $(contentContainer).flowtype({
        minFont: 16,
        fontRatio: initialPageWidth / htmlSizeBase
    });
    $('h1').flowtype({
        minFont: getFontRatio(4) / 2,
        fontRatio: initialHeaderWidth / getFontRatio(4)
    });
    $('h2').flowtype({
        minFont: getFontRatio(3) / 2,
        fontRatio: initialPageWidth / getFontRatio(3)
    });
    $('h3, blockquote p').flowtype({
        minFont: getFontRatio(2) / 2,
        fontRatio: initialPageWidth / getFontRatio(2)
    });
    $('h4').flowtype({
        minFont: getFontRatio(1) / 2,
        fontRatio: initialPageWidth / getFontRatio(1)
    });
    $('h5').flowtype({
        minFont: 16,
        fontRatio: initialPageWidth / getFontRatio(-1)
    });
    $('h6').flowtype({
        minFont: 16,
        fontRatio: initialPageWidth / getFontRatio(-2)
    });
    $('.lead').flowtype({
        minFont: 19,
        fontRatio: initialPageWidth / htmlSizeBase / (1 + ((fontScale - 1) / 2)) / fontSizeBase
    });

});
