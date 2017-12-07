# Docker / Get started / Stacks #

## Prerequisites ##

* Make sure that the machines you set up in part 4 are running and ready. Run **docker-machine ls** to verify this. If the machines are stopped, run **docker-machine start myvm1** to boot the manager, followed by **docker-machine start myvm2** to boot the worker.

* Have the swarm you created in [part 4 (Swarms)](../swarms/README.md) running and ready. Run **docker-machine ssh myvm1 "docker node ls"** to verify this. If the swarm is up, both nodes will report a **ready** status. If not, reinitialze the swarm and join the worker as described in [Set up your swarm](../swarms/README.md).

## Introduction ##

In [part 4 (Swarms)](../swarms/README.md), you learned how to set up a swarm, which is a cluster of machines running Docker, and deployed an application to it, with containers running in concert on multiple machines.

Here in part 5, you’ll reach the top of the hierarchy of distributed applications: the **stack**. A stack is a group of interrelated services that share dependencies, and can be orchestrated and scaled together. A single stack is capable of defining and coordinating the functionality of an entire application (though very complex applications may want to use multiple stacks).

Some good news is, you have technically been working with stacks since part 3, when you created a Compose file and used **docker stack deploy**. But that was a single service stack running on a single host, which is not usually what takes place in production. Here, you will take what you’ve learned, make multiple services relate to each other, and run them on multiple machines.

You’re doing great, this is the home stretch!

## Add a new service and redeploy ##

It’s easy to add services to our **docker-compose.yml** file. First, let’s add a free visualizer service that lets us look at how our swarm is scheduling containers.

1. Open up **docker-compose.yml** in an editor and replace its contents with the following. Be sure to replace **username/repo:tag** with your image details.

        version: "3"
        services:
          web:
            # replace username/repo:tag with your name and image details
            image: username/repo:tag
            deploy:
              replicas: 5
              restart_policy:
                condition: on-failure
              resources:
                limits:
                  cpus: "0.1"
                  memory: 50M
            ports:
              - "80:80"
            networks:
              - webnet
          visualizer:
            image: dockersamples/visualizer:stable
            ports:
              - "8080:8080"
            volumes:
              - "/var/run/docker.sock:/var/run/docker.sock"
            deploy:
              placement:
                constraints: [node.role == manager]
            networks:
              - webnet
        networks:
          webnet:

The only thing new here is the peer service to **web**, named **visualizer**. You’ll see two new things here: a **volumes** key, giving the visualizer access to the host’s socket file for Docker, and a **placement** key, ensuring that this service only ever runs on a swarm manager – never a worker. That’s because this container, built from [an open source project created by Docker](https://github.com/ManoMarks/docker-swarm-visualizer), displays Docker services running on a swarm in a diagram.

We’ll talk more about placement constraints and volumes in a moment.

2. Make sure your shell is configured to talk to **myvm1** (full examples are [here](../swarms/README.md)).

* Run **docker-machine ls** to list machines and make sure you are connected to **myvm1**, as indicated by an asterisk next it.

* If needed, re-run **docker-machine env myvm1**, then run the given command to configure the shell.

    * On Mac or Linux the command is:

            eval $(docker-machine env myvm1)

    * On Windows the command is:

            & "C:\Program Files\Docker\Docker\Resources\bin\docker-machine.exe" env myvm1 | Invoke-Expression

3. Re-run the **docker stack deploy** command on the manager, and whatever services need updating will be updated:

        $ docker stack deploy -c docker-compose.yml getstartedlab
        Updating service getstartedlab_web (id: angi1bf5e4to03qu9f93trnxm)
        Creating service getstartedlab_visualizer (id: l9mnwkeq2jiononb5ihz9u7a4)

4. Take a look at the visualizer.

You saw in the Compose file that **visualizer** runs on port 8080. Get the IP address of one of your nodes by running **docker-machine ls**. Go to either IP address at port 8080 and you will see the visualizer running:

![get-started-visualizer1](https://github.com/marbug/docker/blob/master/quick-start/images/get-started-visualizer1.png)

The single copy of **visualizer** is running on the manager as you expect, and the 5 instances of **web** are spread out across the swarm. You can corroborate this visualization by running **docker stack ps <stack>**:

    docker stack ps getstartedlab

The visualizer is a standalone service that can run in any app that includes it in the stack. It doesn’t depend on anything else. Now let’s create a service that does have a dependency: the Redis service that will provide a visitor counter.

## Persist the data ##

Let’s go through the same workflow once more to add a Redis database for storing app data.

1. Save this new **docker-compose.yml** file, which finally adds a Redis service. Be sure to replace **username/repo:tag** with your image details.

        version: "3"
        services:
          web:
            # replace username/repo:tag with your name and image details
            image: username/repo:tag
            deploy:
              replicas: 5
              restart_policy:
                condition: on-failure
              resources:
                limits:
                  cpus: "0.1"
                  memory: 50M
            ports:
              - "80:80"
            networks:
              - webnet
          visualizer:
            image: dockersamples/visualizer:stable
            ports:
              - "8080:8080"
            volumes:
              - "/var/run/docker.sock:/var/run/docker.sock"
            deploy:
              placement:
                constraints: [node.role == manager]
            networks:
              - webnet
          redis:
            image: redis
            ports:
              - "6379:6379"
            volumes:
              - /home/docker/data:/data
            deploy:
              placement:
                constraints: [node.role == manager]
            command: redis-server --appendonly yes
            networks:
              - webnet
        networks:
          webnet:

TODO

## Useful links ##

[Docker documentation page](https://docs.docker.com/get-started/part5/)

| Navigation               |
| ------------------------ |
| [Level up](../README.md) |
