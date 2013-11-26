#!/bin/bash

case "$1" in
  ssh)
    docker run -i -t kennethklee/red-stack /bin/bash
    ;;

  build)
    make
    ;;

  deploy)
    echo "WIP - This should do a number of thins:"
    echo "1. tar up current directory"
    echo "2. copy and extract the tar in a /app path"
    echo "3. detect and run the appropriate build pack"
    echo "4. create a new image with the changes"
    echo "5. run the app"
    ;;

esac
