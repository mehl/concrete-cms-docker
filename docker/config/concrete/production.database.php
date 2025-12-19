<?php

return [
    'default-connection' => 'concrete',

    'connections' => [
        'concrete' => [
            'driver'   => 'c5_pdo_mysql',
            'server'   => getenv('DB_HOST'),
            'database' => getenv('DB_NAME'),
            'username' => getenv('DB_USER'),
            'password' => getenv('DB_PASS'),
            'charset'  => 'utf8mb4',
            'collation' => 'utf8mb4_unicode_ci',
        ],
    ],
];
