<!DOCTYPE html>
<html>
<head>
    <title>Evolution Template Customizer</title>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-alpha.4/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/spectrum/1.8.0/spectrum.min.css">
    <link rel="stylesheet" type="text/css" href="/assets/plugins/customizer/css/styles.css">
</head>
<body>
    <div class="panel-body">
        <div class="tabs">
            <?php foreach ($settings['tabs'] as $i => $tab): ?>
                <div class="tab<?= !$i? ' active' : '' ?>" data-tab="tab<?= $i ?>"><span><?= $tab['title'] ?></span></div>
            <?php endforeach; ?>
        </div>

        <div class="scrollable">
            <div class="settings">
                <form action="#" method="post">
                    <?php foreach ($settings['tabs'] as $i => $tab): ?>
                        <div class="tab-box<?= !$i? ' active' : '' ?>" data-tab="tab<?= $i ?>">
                            <?php foreach ($tab['fields'] as $field): ?>
                                <?php if ($field['type'] == 'custom'): ?>
                                <?php else: ?>
                                    <?= $this->renderTemplate('tpl/field_' . $field['type'] . '.tpl', [
                                        'field' => $field,
                                        'value' => $values[ $field['name'] ],
                                    ]) ?>
                                <?php endif; ?>
                            <?php endforeach; ?>
                        </div>
                    <?php endforeach; ?>
                </form>
            </div>
        </div>

        <div class="text-xs-right">
            <a href="#" class="btn btn-save">Сохранить</a>
        </div>
    </div>

    <div class="panel-trigger">
        Настройки
    </div>

    <div class="predefined-colors">
        <?php foreach ($settings['colors'] as $color): ?>
            <div class="color" data-color="<?= $color ?>"><div style="background: <?= $color ?>;"></div></div>
        <?php endforeach; ?>
        <div class="color-select"><div></div></div>
    </div>

    <script type="text/javascript">
        var panel_options = {
            path: '<?= $this->path ?>'
        };
    </script>

    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/spectrum/1.8.0/spectrum.min.js"></script>
    <script type="text/javascript" src="js/panel.js"></script>
</body>
</html>