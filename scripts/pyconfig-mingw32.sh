#!/bin/sh
# Ignore first argument
shift
for arg in $@; do
    case $arg in
        --prefix|--exec-prefix)
            echo "$(dirname $1)/../../../python"
            ;;
        --includes)
            echo "-I$(dirname $1)/../../../python/include"
            ;;
        --ldflags)
            echo "-L$(dirname $1)/../../../python/libs -lpython27"
            ;;
    esac
    shift
done
