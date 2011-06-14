#!/bin/bash

find . -name '*.php' -not -wholename \
    '*/Loader/Autoloader.php' \
    -not -wholename '*/Application.php' -print0 | \
    xargs -0 sed --regexp-extended --in-place \
    's/(require_once)/\/\/ \1/g'
