
all: install

install: build install_cli cleanup

cleanup:
	sudo docker images | grep '<none>' | awk '{print $$3}' | sudo xargs docker rmi || true

clean:
	echo "-----> Deleting old instances of the stack"
	sudo docker images | grep 'konquest/red-stack' | awk '{print $$3}' | sudo xargs docker rmi || echo "-----> Old instances not found"
	npm remove -g red-stack

build:
	sudo docker build -t konquest/red-stack .

install_cli:
	npm install -g

