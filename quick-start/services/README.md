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

TODO

| Navigation               |
| ------------------------ |
| [Level up](../README.md) |
