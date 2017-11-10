<?php

class Customizer
{
    private $settings = null;

    private $modx;

    public function __construct($modx = null)
    {
        if ($modx) {
            $this->modx = $modx;
        }
    }

    public function renderTemplate(string $template, array $data) : string
    {
        extract($data);

        ob_start();
        include(__DIR__ . '/' . $template);
        $output = ob_get_contents();
        ob_end_clean();
        
        return $output;
    }

    public function getSettings() : array
    {
        if ($this->settings === null) {
            $this->settings = include __DIR__ . '/config/settings.php';
        }

        return $this->settings;
    }

    public function loadValues() : array
    {
        $values = null;
        
        if (is_readable('config/values.json')) {
            $values = @json_decode(file_get_contents('config/values.json'), true);
        }

        if ($values === null) {
            $settings = $this->getSettings();
            $values = [];

            foreach ($settings['tabs'] as $tab) {
                foreach ($tab['fields'] as $field) {
                    $values[ $field['name'] ] = $field['default'];
                }
            }
        }

        return $values;
    }

    public function registerPlaceholders()
    {
        foreach ($this->loadValues() as $key => $value) {
            $this->modx->setPlaceholder('customizer_' . $key, $value);
        }
    }

    public function renderPanel() : string
    {
        return $this->renderTemplate('tpl/panel.tpl', [
            'settings' => $this->getSettings(),
            'values'   => $this->loadValues(),
        ]);
    }

    public function save()
    {
        $settings = $this->getSettings();
        $values = [];

        foreach ($settings['tabs'] as $tab) {
            foreach ($tab['fields'] as $field) {
                $name = $field['name'];

                if (isset($_POST[$name]) && is_scalar($_POST[$name])) {
                    $values[$name] = $_POST[$name];
                } else {
                    $values[$name] = $field['default'];
                }
            }
        }

        file_put_contents('config/values.json', json_encode($values, JSON_PRETTY_PRINT));

        return json_encode(['status' => 'success']);
    }
}
