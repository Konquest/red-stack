#!/bin/bash

case "$1" in
  ssh)
    if [[ -z "$2" ]]; then
      IMAGE=konquest/red-stack
    else
      IMAGE=red/$2
    fi
    echo "SSHing to $IMAGE"
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
    ID=$(sudo docker run -i $IMAGE /build/builder)
    sudo docker logs $ID
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
