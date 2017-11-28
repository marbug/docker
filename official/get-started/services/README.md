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

## Run your new load-balanced app ##

Before we can use the **docker stack deploy** command we’ll first run:

    docker swarm init

**Note:** We’ll get into the meaning of that command in [part 4](../swarms/README.md). If you don’t run docker swarm init you’ll get an error that “this node is not a swarm manager.”

You'll see something like the following:

    warm initialized: current node (qjty6tdftu2vy4ux5pb116n8s) is now a manager.

    To add a worker to this swarm, run the following command:

        docker swarm join --token SWMTKN-1-1mw68en89a6tvlivqyzmujh1ccyqpvtdgctifsxwducwd5rgcy-5fydsrmdux56jhch853wx52mc 192.168.65.2:2377

    To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

Now let’s run it. You have to give your app a name. Here, it is set to **getstartedlab**:

    docker stack deploy -c docker-compose.yml getstartedlab

You'll see something like the following:

    Creating network getstartedlab_webnet
    Creating service getstartedlab_web


Our single service stack is running 5 container instances of our deployed image on one host. Let’s investigate.

Get the service ID for the one service in our application:

    docker service ls

You’ll see output for the **web** service, prepended with your app name. If you named it the same as shown in this example, the name will be **getstartedlab_web**. The service ID is listed as well, along with the number of replicas, image name, and exposed ports. Something like the following:

    ID                  NAME                MODE                REPLICAS            IMAGE                       PORTS
    kedxlcfb2wqu        getstartedlab_web   replicated          5/5                 marabug/get-started:part2   *:80->80/tcp

A single container running in a service is called a **task**. Tasks are given unique IDs that numerically increment, up to the number of **replicas** you defined in **docker-compose.yml**. List the tasks for your service:

    docker service ps getstartedlab_web

i.e.

    ID                  NAME                  IMAGE                       NODE                DESIRED STATE       CURRENT STATE           ERROR               PORTS
    8l4lkiddyen1        getstartedlab_web.1   marabug/get-started:part2   moby                Running             Running 4 minutes ago
    pwaalhvkwbt4        getstartedlab_web.2   marabug/get-started:part2   moby                Running             Running 4 minutes ago
    tszjx1s4r4ly        getstartedlab_web.3   marabug/get-started:part2   moby                Running             Running 4 minutes ago
    di6xmsapdv8w        getstartedlab_web.4   marabug/get-started:part2   moby                Running             Running 4 minutes ago
    rukvm8g5t483        getstartedlab_web.5   marabug/get-started:part2   moby                Running             Running 4 minutes ago

Tasks also show up if you just list all the containers on your system, though that will not be filtered by service:

    docker container ls -q

You can run **curl -4 http://localhost** several times in a row, or go to that URL in your browser and hit refresh a few times.

Either way, you’ll see the container ID change, demonstrating the load-balancing; with each request, one of the 5 tasks is chosen, in a round-robin fashion, to respond. The container IDs will match your output from the previous command (**docker container ls -q**).

**Slow response times?**

Depending on your environment’s networking configuration, it may take up to 30 seconds for the containers to respond to HTTP requests. This is not indicative of Docker or swarm performance, but rather an unmet Redis dependency that we will address later in the tutorial. For now, the visitor counter isn’t working for the same reason; we haven’t yet added a service to persist data.

## Scale the app ##

TODO

## Useful links ##

[Docker documentation page](https://docs.docker.com/get-started/part3/)

| Navigation               |
| ------------------------ |
| [Level up](../README.md) |
