# Docker / Get started / Swarms #

## Introduction ##

In [part 3 (services)](../services/README.md), you took an app you wrote in [part 2 (containers)](../containers/README.md), and defined how it should run in production by turning it into a service, scaling it up 5x in the process.

Here in part 4, you deploy this application onto a cluster, running it on multiple machines. Multi-container, multi-machine applications are made possible by joining multiple machines into a “Dockerized” cluster called a swarm.

## Understanding Swarm clusters ##

A swarm is a group of machines that are running Docker and joined into a cluster. After that has happened, you continue to run the Docker commands you’re used to, but now they are executed on a cluster by a **swarm manager**. The machines in a swarm can be physical or virtual. After joining a swarm, they are referred to as **nodes**.

TODO

## Useful links ##

[Docker documentation page](https://docs.docker.com/get-started/part4/)

| Navigation               |
| ------------------------ |
| [Level up](../README.md) |
