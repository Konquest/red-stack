#!/bin/bash

case "$1" in
  ssh)
    if [[ -z "$2" ]]; then
      IMAGE=red/$2
    else
      IMAGE=kennethklee/red-stack
    fi
    docker run -i -t $IMAGE /bin/bash
    ;;

  deploy)
    echo "Deploying image"
    echo "5. run the app"

    [ "$#" -eq 2 ] || die "Requires app name argument"

    NAME="$2"
    IMAGE=red/$NAME

    ID=$(tar -cf - . | docker run -i -a stdin kennethklee/red-stack /bin/bash -c "mkdir -p /app && tar -xC /app && /build/builder")
    test $(docker wait $ID) -eq 0
    docker commit $ID $IMAGE > /dev/null 


    # TODO run the app
    ;;

  *)
    echo "Please use script with arguments ssh|deploy"

esac
