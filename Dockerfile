FROM backjlack/centos-6.4-x86_64
MAINTAINER kennethklee "kennethkl@gmail.com"

RUN date
RUN rpm -iUvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum -y update
RUN yum -y upgrade

RUN mkdir /build
ADD ./stack /build
RUN LC_ALL=C /build/prepare

RUN yum -y clean all
