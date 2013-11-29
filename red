#!/bin/bash

case "$1" in
  ssh)
    if [[ -z "$2" ]]; then
      IMAGE=red/$2
    else
      IMAGE=konquest/red-stack
    fi
    sudo docker run -i -t $IMAGE /bin/bash
    ;;

  init)
    echo "Initialize app to stack (copy over to /app)"

    [ "$#" -eq 2 ] || die "Requires app name argument"
    NAME="$2"
    IMAGE=red/$NAME

    ID=$(tar -cf - . | cat | sudo docker run -i -a stdin konquest/red-stack /bin/bash -c "mkdir -p /app && tar -xC /app")
    test $(sudo docker wait $ID) -eq 0
    sudo docker commit $ID $IMAGE > /dev/null 
    echo "Copied app"
    ;;

  build)
    echo "Building app..."

    [ "$#" -eq 2 ] || die "Requires app name argument"
    NAME="$2"
    IMAGE=red/$NAME

    exec 5>&1
    ID=$(sudo docker run -d $IMAGE /build/builder | tee > (cat - >&5))
    test $(sudo docker wait $ID) -eq 0
    sudo docker commit $ID $IMAGE > /dev/null
    echo "Built app"
    ;;

  run)
    echo "TODO 2. run the app"
    ;;

  *)
    echo "Please use script with arguments ssh|init|build"

esac
