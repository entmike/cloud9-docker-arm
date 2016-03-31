Cloud9 v3 Dockerfile
=============

This is a fork from [kdelfour](https://github.com/kdelfour/cloud9-docker). I also used [flyingprogrammer's repo](https://github.com/flyinprogrammer/cloud9-with-carina) for reference.  Much thanks to those two for their excellent work.

The major differences in this fork are the following:
  1. This is an ARM architecture
  1. Node runs as a non-root user - hence port 8080

# Base Docker Image
[armv7/armhf-ubuntu:14.10](https://hub.docker.com/r/armv7/armhf-ubuntu/)

# Docker Hub Image
[barrywilliams/cloud9-docker-arm](https://hub.docker.com/r/barrywilliams/cloud9-docker-arm/)

# Installation

## Install Docker
Follow [Hypriot's Blog]() to install docker on a Raspberry Pi

## Usage

```
docker run -it -d -p 80:8080 barrywilliams/cloud9-docker-arm
```    
You can also provide auth credentials
```    
docker run -d -p 80:8080 -e AUTH=user:pass barrywilliams/cloud9-docker-arm
``` 
And the collab flag
```    
docker run -d -p 80:8080 -e COLLAB=true barrywilliams/cloud9-docker-arm
```

You can add a workspace as a volume directory with the argument `-v /your-path/workspace/:/workspace/` like this :
```
docker run -it -d -p 80:8080 -v /your-path/workspace/:/workspace/ barrywilliams/cloud9-docker-arm
```    
## Build It

Clone the latest repo on a Raspberry Pi with Docker.
```
git clone https://github.com/barrywilliams/cloud9-docker-arm
```

Build it
```
docker build cloud9-docker-arm/ --force-rm=true --tag="$USER/cloud9-docker-arm:latest" .
```   
And run
```
docker run -d -p 80:80 -v /your-path/workspace/:/workspace/ $USER/cloud9-docker-arm:latest
``` 
Enjoy !!    
