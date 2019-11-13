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
            echo "-I${pydir}/../../../python/include"
            ;;
        --ldflags)
            echo "-L${pydir}/../../../python/libs -lpython27"
            ;;
    esac
    shift
done
