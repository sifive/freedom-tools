#!/bin/sh
# Ignore first argument
pydir=$(dirname $1)
shift
for arg in $@; do
    case $arg in
        --prefix|--exec-prefix)
            echo "${pydir}/../../../python"
            ;;
        --includes)
            echo "-I${pydir}/../../../python/include/python2.7"
            ;;
        --ldflags)
            echo "-Wl,--export-dynamic -L${pydir}/../../../python/lib/python2.7/config -Wl,--whole-archive -lpython2.7 -Wl,--no-whole-archive -lpthread -ldl -lutil -lm"
            ;;
    esac
    shift
done
