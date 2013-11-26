#!/bin/bash
echo $#
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
    echo "WIP - This should do a number of things:"
    echo "1. tar up current directory"
    echo "2. copy and extract the tar in a /app path"
    echo "3. detect and run the appropriate build pack"
    echo "4. create a new image with the changes"
    echo "5. run the app"

    [ "$#" -eq 2 ] || die "Requires app name argument"

    NAME="$1"
    TAG="$2"

    if [[ -z "$TAG" ]]; then
      IMAGE=red/$NAME
    else
      IMAGE=red/$NAME:$TAG
    fi

    ID=$(tar -cf - . | docker run -i -a stdin kennethklee/red-stack /bin/bash -c "mkdir -p /app && tar -xC /app && /build/builder")
    test $(docker wait $ID) -eq 0
    docker commit $ID $IMAGE > /dev/null 

    ;;

  *)
    echo "Please use script with arguments ssh|build|deploy"

esac
