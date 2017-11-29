# Docker / Quick start / Services #

On this page we'll scale our application and enable load-balancing.

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

**Note:** We’ll get into the meaning of that command in [part 4](../swarms/README.md). If you don’t run **docker swarm init** you’ll get an error that “this node is not a swarm manager.”

Now let’s run it. You have to give your app a name. Here, it is set to **getstartedlab**:

    docker stack deploy -c docker-compose.yml getstartedlab

Our single service stack is running 5 container instances of our deployed image on one host. Let’s investigate.

Get the service ID for the one service in our application:

    docker service ls

A single container running in a service is called a **task**. Tasks are given unique IDs that numerically increment, up to the number of **replicas** you defined in **docker-compose.yml**. List the tasks for your service:

    docker service ps getstartedlab_web

## Scale the app ##

You can scale the app by changing the **replicas** value in **docker-compose.yml**, saving the change, and re-running the **docker stack deploy** command:

    docker stack deploy -c docker-compose.yml getstartedlab

Docker will do an in-place update, no need to tear the stack down first or kill any containers.

Now, re-run **docker container ls -q** to see the deployed instances reconfigured. If you scaled up the replicas, more tasks, and hence, more containers, are started.

## Take down the app and the swarm ##

* Take the app down with **docker stack rm**:

        docker stack rm getstartedlab

* Take down the swarm.

        docker swarm leave --force

## Useful links ##

[Docker documentation page](https://docs.docker.com/get-started/part3/)

| Navigation               |
| ------------------------ |
| [Level up](../README.md) |
