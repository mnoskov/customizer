$(function() {
    $('.panel-trigger').click(function(e) {
        var $iframe = $(window.parent.document.body).children('.customizer-panel'),
            classname = 'customizer-opened';

        if ($iframe.hasClass(classname)) {
            $iframe.removeClass(classname);
            $iframe.animate({left: -560}, 400);
        } else {
            $iframe.addClass(classname);
            $iframe.animate({left: 0}, 400);
        }
    });

    $('.btn-save').click(function(e) {
        e.preventDefault();
        
        $.post('/assets/plugins/customizer/router.php', $('.settings > form').serialize() + '&action=save', function(response) {
            window.parent.location.reload();
        });
    });

    $('.tabs').on('click', '.tab:not(.active)', function(e) {
        $(this).addClass('active').siblings('.active').removeClass('active');
        $('.tab-box[data-tab="' + $(this).attr('data-tab') + '"]').addClass('active').siblings('.active').removeClass('active');
    });

    var colors = $('.predefined-colors').html();
    $('.predefined-colors').remove();

    $('.color-selector').each(function() {
        $(this).append(colors);

        var color   = $(this).prev('input').val(),
            $active = $(this).children('[data-color="' + color + '"]'),
            $custom = $(this).children('.color-select');

        if ($active.length) {
            $active.addClass('active');
        } else {
            $custom.addClass('active').children().css('background', color);
        }

        $(this).children('.color').click(function(e) {
            e.preventDefault();
            $(this).addClass('active').siblings('.active').removeClass('active');
            $(this).parent().prev('input').val($(this).attr('data-color'));
        });

        !function($element) {
            $element
                .on('beforeShow.spectrum', function(e, color) {
                    var color = $element.children().css('background-color');

                    $element.addClass('active').siblings('.active').removeClass('active');
                    $element.parent().prev('input').val(color);
                    $(this).spectrum('set', color);
                })
                .spectrum({
                    allowEmpty: false,
                    showInput: true,
                    showAlpha: true,
                    showInitial: true,
                    showButtons: false,
                    preferredFormat: 'hex',
                    move: function(color) {
                        color = color.toHexString();
                        $element.children().css('background-color', color);
                        $element.parent().prev('input').val(color);
                    }
                });
        }($custom);
    });

    $('.toggle-group').each(function() {
        $(this).find('label input').after('<span class="toggler"/>');
    });
});