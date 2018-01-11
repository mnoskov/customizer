<?php

class Customizer
{
    private $settings = null;

    private $modx;

    private $base;
    private $path = 'config/values.json';

    public function __construct($modx = null)
    {
        $this->base = realpath(__DIR__ . '/../../../');

        if ($modx) {
            $this->modx = $modx;
        }
    }

    public function setPath($path) {
        if (is_string($path)) {
            $path = $this->base . '/' . $path;
            $info = pathinfo($path);

            if (!empty($info['dirname']) && is_dir($info['dirname']) && is_writable($info['dirname'])) {
                $path = realpath($info['dirname']);

                if ($path !== false) {
                    $path = str_replace($this->base, '', $path);
                    $this->path = trim($path . '/' . $info['basename'], '/');
                }
            }
        }
    }

    public function getPath() {
        return $this->base . '/' . $this->path;
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

        $path = $this->getPath();
        
        if (is_readable($path)) {
            $values = @json_decode(file_get_contents($path), true);
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

        $path = $this->getPath();

        if (is_readable($path)) {
            $values = @json_decode(file_get_contents($path), true);
        }

        $values['stamp'] = time();

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

        file_put_contents($path, json_encode($values, JSON_PRETTY_PRINT));

        return json_encode(['status' => 'success']);
    }
}
