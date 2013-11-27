
all: clean build install

clean:
	echo "-----> Deleting old instances of the stack"
	sudo docker images | grep 'konquest/red-stack' | awk '{print $$3}' | sudo xargs docker rmi || echo "-----> Deleted old instance"

build:
	sudo docker build -t konquest/red-stack .

install: install_cli

install_cli:
	npm install -g

cleanup:
	sudo docker images | grep '<none>' | awk '{print $$3}' | sudo xargs docker rmi || true

