
all: clean build install

build:
	sudo docker build -t konquest/red-stack .

install:
	npm install -g

clean:
	sudo docker images | grep 'konquest/red-stack' | awk '{print $3}' | xargs docker rmi &> /dev/null
