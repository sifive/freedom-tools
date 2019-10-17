#!/bin/sh
# Ignore first argument
shift
for arg in $@; do
    case $arg in
        --prefix|--exec-prefix)
            echo "$(dirname $1)/../../../python"
            ;;
        --includes)
            echo "-I$(dirname $1)/../../../python/include/python2.7"
            ;;
        --ldflags)
            echo "-Wl,--export-dynamic -L$(dirname $1)/../../../python/lib/python2.7/config -Wl,--whole-archive -lpython2.7 -Wl,--no-whole-archive -lpthread -ldl -lutil -lm"
            ;;
    esac
    shift
done
