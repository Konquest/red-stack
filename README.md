red-stack
=========

CentOS vm stack that can handle buildpacks

Note: Inspiration comes from https://github.com/progrium/buildsteps

requirements
------------

* git
* Docker
* NPM


installation
------------

1. Clone the repo
```
git clone https://github.com/Konquest/red-stack.git
```

2. Install
```
make
```

All done!


usage
-----

```
red init <app name>
```
Creates a new image from the red-stack base. Copies the current directory into the /app directory. The new image will have the name `red/<app name>`

```
red build <app name>
```
Initializes the builder from https://github.com/progrium/buildstep which invokes the heroku buildpacks and builds the application. It also creates a command within the image, `/start`, to start the application.

```
red ssh <app name>
```
Simply ssh into the application docker image.
