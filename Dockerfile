FROM centos
MAINTAINER kennethklee "kennethkl@gmail.com"

RUN date
RUN yum -y update
RUN yum -y upgrade
RUN yum -y install yum-priorities

RUN mkdir /build
ADD ./stack /build
RUN LC_ALL=C /build/prepare

RUN yum -y clean
