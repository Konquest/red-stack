
all: build install

build:
	sudo docker build -t konquest/red-stack .

install:
	npm install -g

