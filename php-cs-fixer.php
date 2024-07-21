<?php

use PhpCsFixer\Config;

return (new Config())->setRules(
    [
        '@PSR12' => true,
        '@Symfony' => true,
        //   'strict_param' => true,
        //   'array_syntax' => ['syntax' => 'short'],
        //   'indentation_type' => true, // Ensures spaces or tabs are used consistently
        // 'braces' => ['position_after_functions_and_oop_constructs' => 'same'],
        // 'array_syntax' => ['syntax' => 'short'],
        //   'binary_operator_spaces' => ['default' => 'align_single_space_minimal'],
        // 'indent' => 4
    ]
);
