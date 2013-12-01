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
    IMAGE=red/$2

    ID=$(tar -cf - . | cat | sudo docker run -i -a stdin konquest/red-stack /bin/bash -c "mkdir -p /app && tar -xC /app")
    test $(sudo docker wait $ID) -eq 0
    sudo docker commit $ID $IMAGE > /dev/null 
    echo "Copied app"
    ;;

  build)
    echo "Building app..."

    [ "$#" -eq 2 ] || die "Requires app name argument"
    IMAGE=red/$2

    exec 5>&1
    ID=$(sudo docker run -d $IMAGE /build/builder)
    sudo docker attach $ID
    test $(sudo docker wait $ID) -eq 0
    sudo docker commit $ID $IMAGE > /dev/null
    ;;

  cleanup)
    sudo docker images | grep '<none>' | awk '{print $$3}' | sudo xargs docker rmi || true
    ;;

  run)
    IMAGE=red/$2

    ID=$(sudo docker run -d -p 8080 -e PORT=8080 $IMAGE /bin/bash -c "/start web")
    PORT=$(sudo docker port $ID 8080 | sed 's/0.0.0.0://')
    echo "running at http://localhost:$PORT"
    ;;

  help)
    echo "usage: red <command>"
    echo
    echo "commands:"
    echo "init <app>   Initializes an image from base. Copies current directory to /app."
    echo "build <app>  Builds the application in /app and creates a command /start."
    echo "ssh <app>    SSH into the image."
    echo "help         Display this help dialog."
    ;;

  *)
    echo "Please use script with arguments ssh|init|build|help"

esac
