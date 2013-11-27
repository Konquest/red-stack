
all: clean build install

clean:
	sudo docker images | grep 'konquest/red-stack' | awk '{print $$3}' | sudo xargs docker rmi || true

build:
	sudo docker build -t konquest/red-stack .

install: install_cli

install_cli:
	npm install -g

cleanup:
	sudo docker images | grep '<none>' | awk '{print $$3}' | sudo xargs docker rmi || true

