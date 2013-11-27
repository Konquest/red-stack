#!/bin/bash

case "$1" in
  ssh)
    if [[ -z "$2" ]]; then
      IMAGE=red/$2
    else
      IMAGE=konquest/red-stack
    fi
    docker run -i -t $IMAGE /bin/bash
    ;;

  deploy)
    echo "Deploy app to stack"

    [ "$#" -eq 2 ] || die "Requires app name argument"

    NAME="$2"
    IMAGE=red/$NAME

    ID=$(tar -cf - . | docker run -i -a stdin konquest/red-stack /bin/bash -c "mkdir -p /app && tar -xC /app && /build/builder")
    test $(docker wait $ID) -eq 0
    docker commit $ID $IMAGE > /dev/null 
    echo "Copied app to image"

    echo "TODO 1. build app"
    echo "TODO 2. run the app"
    ;;

  *)
    echo "Please use script with arguments ssh|deploy"

esac
