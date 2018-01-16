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
        
        $.post('/assets/plugins/customizer/router.php', $('.settings > form').serialize() + '&action=save&path=' + panel_options.path, function(response) {
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
        var $self = $(this);

        $self.append(colors);

        var $input  = $self.parent().children('input[type="hidden"]'),
            color   = $input.val(),
            $active = $self.children('[data-color="' + color + '"]'),
            $custom = $self.children('.color-select'),
            $group  = $self.closest('.field-group');

        if ($active.length) {
            $active.addClass('active');
        } else {
            if (color.match(/^#/)) {
                $custom.addClass('active').children().css('background', color);
            }
        }

        !function($element, $group, $input) {
            $self.children('.color').click(function(e) {
                e.preventDefault();
                $(this).addClass('active').siblings('.active').removeClass('active');
                $input.val($(this).attr('data-color'));

                $group.find('[type="radio"]').each(function() {
                    this.checked = false;
                });
            });

            $element
                .on('beforeShow.spectrum', function(e, color) {
                    var color = $element.children().css('background-color');

                    $element.addClass('active').siblings('.active').removeClass('active');
                    $input.val(color);
                    $(this).spectrum('set', color);

                    $group.find('[type="radio"]').each(function() {
                        this.checked = false;
                    });
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
                        $input.val(color);
                    }
                });
        }($custom, $group, $input);
    });

    $('.radio-group.color-group').each(function() {
        var $group = $(this);

        $(this).find('[type="radio"]').change(function() {
            $group.children('.color-selector').children('.active').removeClass('active');
        });
    });

    $('.toggle-group').each(function() {
        $(this).find('label input').after('<span class="toggler"/>');
    });
});
