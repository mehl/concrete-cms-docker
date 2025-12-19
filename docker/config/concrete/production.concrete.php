<?php

return [
    'mail' => [
        'method' => 'smtp',

        'methods' => [
            'smtp' => [
                'server'     => getenv('MAIL_HOST'),
                'port'       => getenv('MAIL_PORT'),
                'username'   => getenv('MAIL_USER'),
                'password'   => getenv('MAIL_PASS'),
                'encryption' => getenv('MAIL_ENCRYPTION'),
            ],
        ],
    ],
];
