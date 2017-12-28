//<?php
/**
 * Customizer
 * 
 * Creates panel for customize site theme
 *
 * @category    plugin
 * @version     1.0.0
 * @author      mnoskov
 * @internal    @properties &path=Path to json with variables;text;/assets/templates/default/css/variables.json 
 * @internal    @events OnWebPageInit
 * @internal    @modx_category Manager and Admin
 * @internal    @installset base,sample
 */

$e = &$modx->event;

switch ($e->name) {
    case 'OnWebPageInit': {
        include 'assets/plugins/customizer/customizer.php';

        $customizer = new Customizer($modx);
        $customizer->registerPlaceholders();

        if (!empty($_SESSION['mgrValidated']) && !empty($_SESSION['mgrInternalKey'])) {
            $modx->regClientHTMLBlock('<iframe class="customizer-panel" src="/assets/plugins/customizer/router.php?' . http_build_query($params). '" style="position: fixed; width: 600px; height: 100%; border: 0; top: 0; bottom: 0; left: -560px; z-index: 9999999;"></iframe>');
        }

        return;
    }
}
