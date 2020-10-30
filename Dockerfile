## To create docker image with the following attributes, run:
# docker build -t tveta/runciri:v1 .	[<username>/<repo>:<tag>]
# docker run -it tveta/runciri:v1
# docker push tveta/runciri:v1

# Specify the base image -- here we're using one that bundles the OpenJDK version of Java 8 on top of a generic Debian Linux OS
FROM openjdk:8-jdk-slim

#Set the working directory to be used when the docker gets run
WORKDIR /usr

# Do a few updates of the base system and install R (via the r-base package)
RUN apt-get update && \
        apt-get upgrade -y && \
        apt-get install -y r-base 

# Install git
RUN apt install -y git-all

# Install bwa
RUN git clone https://github.com/lh3/bwa.git && \
	cd bwa && \
	make && \
        cp bwa ../sbin

## Install complete CIRI-full package
# Add jar files (assumes the jar file is in the same directory as the Dockerfile, but you could provide a path to another location)
COPY CIRI-full.jar /usr/sbin/CIRI-full.jar

COPY CIRI-vis.jar /usr/sbin/CIRI-vis.jar

COPY CIRI2.pl /usr/sbin/CIRI2.pl

COPY CIRI_AS_v1.2.pl /usr/sbin/CIRI_AS_v1.2.pl
