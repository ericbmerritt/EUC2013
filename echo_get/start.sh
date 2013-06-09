#!/bin/sh
erl -noshell -pa ebin deps/*/ebin -s echo_get manual_start \
        -eval "io:format(\"Point your browser at http://localhost:8080/?echo=test~n\")."
