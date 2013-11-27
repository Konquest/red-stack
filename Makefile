
all: clean build install

build:
	sudo docker build -t konquest/red-stack .

install:
	npm install -g

clean:
	sudo docker rmi konquest/red-stack
