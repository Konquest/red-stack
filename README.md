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
red deploy <app name>
```
Deploys the current directory to a docker image with the name red/<app name>


```
red ssh <app name>
```
Simply ssh into the application docker image.

