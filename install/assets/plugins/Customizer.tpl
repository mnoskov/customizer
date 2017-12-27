//<?php
/**
 * Customizer
 * 
 * Creates panel for customize site theme
 *
 * @category    plugin
 * @version     1.0.0
 * @author      mnoskov
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
            
        $modx->regClientHTMLBlock('<iframe class="customizer-panel" src="/assets/plugins/customizer/router.php" style="position: fixed; width: 600px; height: 100%; border: 0; top: 0; bottom: 0; left: -560px; z-index: 9999999;"></iframe>');
        
        return;
    }
}
