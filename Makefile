
all: clean build install

build:
	sudo docker build -t konquest/red-stack .

install: install_cli cleanup

install_cli:
	npm install -g

cleanup:
	sudo docker images | grep '<none>' | awk '{print $$3}' | sudo xargs docker rmi || true

clean:
	sudo docker images | grep 'konquest/red-stack' | awk '{print $$3}' | sudo xargs docker rmi || true
