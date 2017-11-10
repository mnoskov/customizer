<?php

    include 'customizer.php';

    $customizer = new Customizer();

    if (isset($_SERVER['REQUEST_METHOD']) && $_SERVER['REQUEST_METHOD'] == 'POST') {
        echo $customizer->save();
    } else {
        echo $customizer->renderPanel();
    }

