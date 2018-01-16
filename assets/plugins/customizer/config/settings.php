<?php

return [
    'tabs' => [
        [
            'title'  => 'Основные',
            'fields' => [
                [
                    'name'    => 'primary_color',
                    'title'   => 'Основной цвет',
                    'type'    => 'color',
                    'default' => '#107bb1'
                ], [
                    'name'    => 'buttons_color',
                    'title'   => 'Цвет кнопок',
                    'type'    => 'color',
                    'default' => '#ff6d00'
                ], [
                    'name'    => 'toggle',
                    'title'   => 'Переключатель',
                    'type'    => 'checkbox',
                    'default' => 1,
                ], [
                    'name'    => 'images',
                    'title'   => 'Изображения',
                    'type'    => 'radioimages',
                    'default' => 1,
                    'images'  => [
                        1 => 'images/head1.png',
                        'images/head2.png',
                        'images/head3.png',
                    ],
                ], 
            ]
        ], [
            'title'  => 'Главная страница',
            'fields' => [],
        ], [
            'title'  => 'Шапка',
            'fields' => [
                [
                    'name'    => 'menu_background',
                    'title'   => 'Фон меню в шапке',
                    'type'    => 'radio_and_color',
                    'values'  => [
                        '@primary_color' => 'Основной цвет',
                        '@buttons_color' => 'Цвет кнопок',
                    ],
                    'default' => '@primary_color',
                ],
            ],
        ],
    ],

    'colors' => [
        '#ffad00', '#ff6d00', '#e65100', '#de002b', '#b41818', '#bd1c3c', 
        '#d75cb6', '#5f58ac', '#1976d2', '#0088cc', '#107bb1', '#497c9d', 
        '#0fa8ae', '#0d897f', '#1b9e77', '#188b30', '#48a216',
    ],
];
