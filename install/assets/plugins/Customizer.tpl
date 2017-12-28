//<?php
/**
 * Customizer
 * 
 * Creates panel for customize site theme
 *
 * @category    plugin
 * @version     1.0.0
 * @author      mnoskov
 * @internal    @properties &path=Path to json with variables;text;/assets/templates/default/css/variables.json &onlyAuthorized=Show panel for authorized user only;menu;true,false;true
 * @internal    @events OnWebPageInit,OnWebPagePrerender
 * @internal    @modx_category Manager and Admin
 * @internal    @installset base,sample
 */

$e = &$modx->event;

switch ($e->name) {
    case 'OnWebPageInit': {
        include 'assets/plugins/customizer/customizer.php';
        $customizer = new Customizer($modx);
        $customizer->registerPlaceholders();
        return;
    }

    case 'OnWebPagePrerender': {
        $isAuthorized = !empty($_SESSION['mgrValidated']) && !empty($_SESSION['mgrInternalKey']);

        if ($isAuthorized || $params['onlyAuthorized'] == 'false') {
            $modx->documentOutput = str_replace('</body>', '<iframe class="customizer-panel" src="/assets/plugins/customizer/router.php?' . http_build_query(['path' => $params['path']]). '" style="position: fixed; width: 600px; height: 100%; border: 0; top: 0; bottom: 0; left: -560px; z-index: 9999999;"></iframe></body>', $modx->documentOutput);
        }
        return;
    }
}
