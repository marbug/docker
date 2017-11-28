# Docker / Get started / Services #

## Prerequisites ##

* Install Docker version 1.13 or higher.

* Get [Docker Compose](https://docs.docker.com/compose/overview/). On [Docker for Mac](https://docs.docker.com/docker-for-mac/) and [Docker for Windows](https://docs.docker.com/docker-for-windows/) it’s pre-installed, so you’re good-to-go. On Linux systems you will need to [install it directly](https://github.com/docker/compose/releases). On pre Windows 10 systems without Hyper-V, use [Docker Toolbox](https://docs.docker.com/toolbox/overview/).

* Make sure you have published the **friendlyhello** image you created by pushing it to a registry. We’ll use that shared image here.

* Be sure your image works as a deployed container. Run this command, slotting in your info for **username**, **repo**, and **tag**:

    docker run -p 80:80 username/repo:tag

then visit [http://localhost/](http://localhost/).

## Introduction ##

On this page we'll scale our application and enable load-balancing.

## About services ##

In a distributed application, different pieces of the app are called “services.” For example, if you imagine a video sharing site, it probably includes a service for storing application data in a database, a service for video transcoding in the background after a user uploads something, a service for the front-end, and so on.

Services are really just “containers in production.” A service only runs one image, but it codifies the way that image runs — what ports it should use, how many replicas of the container should run so the service has the capacity it needs, and so on. Scaling a service changes the number of container instances running that piece of software, assigning more computing resources to the service in the process.

Luckily it’s very easy to define, run, and scale services with the Docker platform – just write a **docker-compose.yml** file.

## docker-compose.yml ##

A **docker-compose.yml** file is a YAML file that defines how Docker containers should behave in production.

Save the following text as **docker-compose.yml** wherever you want. Be sure you have [pushed the image](../share-image/README.md) you created in Part 2 to a registry, and update this **.yml** by replacing **username/repo:tag** with your image details.

    version: "3"
    services:
      web:
        # replace username/repo:tag with your name and image details
        image: username/repo:tag
        deploy:
          replicas: 5
          resources:
            limits:
              cpus: "0.1"
              memory: 50M
          restart_policy:
            condition: on-failure
        ports:
          - "80:80"
        networks:
          - webnet
    networks:
      webnet:

This **docker-compose.yml** file tells Docker to do the following:

* Pull the image from the registry.

* Run 5 instances of that image as a service called **web**, limiting each one to use, at most, 10% of the CPU (across all cores), and 50MB of RAM.

* Immediately restart containers if one fails.

* Map port 80 on the host to **web**’s port 80.

* Instruct **web**’s containers to share port 80 via a load-balanced network called **webnet**. (Internally, the containers themselves will publish to **web**’s port 80 at an ephemeral port.)

* Define the **webnet** network with the default settings (which is a load-balanced overlay network).

TODO

## Useful links ##

[Docker documentation page](https://docs.docker.com/get-started/part3/)

| Navigation               |
| ------------------------ |
| [Level up](../README.md) |
