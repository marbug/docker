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

TODO

## Useful links ##

[Docker documentation page](https://docs.docker.com/get-started/part5/)

| Navigation               |
| ------------------------ |
| [Level up](../README.md) |
