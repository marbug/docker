# Docker / Get started / Swarms #

## Introduction ##

In [part 3 (services)](../services/README.md), you took an app you wrote in [part 2 (containers)](../containers/README.md), and defined how it should run in production by turning it into a service, scaling it up 5x in the process.

Here in part 4, you deploy this application onto a cluster, running it on multiple machines. Multi-container, multi-machine applications are made possible by joining multiple machines into a “Dockerized” cluster called a swarm.

## Understanding Swarm clusters ##

A swarm is a group of machines that are running Docker and joined into a cluster. After that has happened, you continue to run the Docker commands you’re used to, but now they are executed on a cluster by a **swarm manager**. The machines in a swarm can be physical or virtual. After joining a swarm, they are referred to as **nodes**.

Swarm managers can use several strategies to run containers, such as “emptiest node” – which fills the least utilized machines with containers. Or “global”, which ensures that each machine gets exactly one instance of the specified container. You instruct the swarm manager to use these strategies in the Compose file, just like the one you have already been using.

Swarm managers are the only machines in a swarm that can execute your commands, or authorize other machines to join the swarm as **workers**. Workers are just there to provide capacity and do not have the authority to tell any other machine what it can and cannot do.

Up until now, you have been using Docker in a single-host mode on your local machine. But Docker also can be switched into **swarm mode**, and that’s what enables the use of swarms. Enabling swarm mode instantly makes the current machine a swarm manager. From then on, Docker will run the commands you execute on the swarm you’re managing, rather than just on the current machine.

## Set up your swarm ##

A swarm is made up of multiple nodes, which can be either physical or virtual machines. The basic concept is simple enough: run **docker swarm init** to enable swarm mode and make your current machine a swarm manager, then run **docker swarm join** on other machines to have them join the swarm as workers. Choose a section below to see how this plays out in various contexts. We’ll use VMs to quickly create a two-machine cluster and turn it into a swarm.

## Create a cluster ##

### Local VMs (Mac, Linux, Windows 7 and 8) ###

#### VMS ON YOUR LOCAL MACHINE (MAC, LINUX, WINDOWS 7 AND 8) ####

First, you’ll need a hypervisor that can create virtual machines (VMs), so [install Oracle VirtualBox](https://www.virtualbox.org/wiki/Downloads) for your machine’s OS.

**Note:** If you are on a Windows system that has Hyper-V installed, such as Windows 10, there is no need to install VirtualBox and you should use Hyper-V instead. View the instructions for Hyper-V systems below. If you are using Docker Toolbox, you should already have VirtualBox installed as part of it, so you are good to go.

Now, create a couple of VMs using **docker-machine**, using the VirtualBox driver:

    docker-machine create --driver virtualbox myvm1
    docker-machine create --driver virtualbox myvm2

### Local VMs (Windows 10/Hyper-V) ###

#### VMS ON YOUR LOCAL MACHINE (WINDOWS 10) ####

First, quickly create a virtual switch for your virtual machines (VMs) to share, so they will be able to connect to each other.

    1. Launch Hyper-V Manager
    2. Click **Virtual Switch Manager** in the right-hand menu
    3. Click **Create Virtual Switch** of type **External**
    4. Give it the name **myswitch**, and check the box to share your host machine’s active network adapter

Now, create a couple of VMs using our node management tool, **docker-machine**:

    docker-machine create -d hyperv --hyperv-virtual-switch "myswitch" myvm1
    docker-machine create -d hyperv --hyperv-virtual-switch "myswitch" myvm2

### LIST THE VMS AND GET THEIR IP ADDRESSES ###

You now have two VMs created, named **myvm1** and **myvm2**.

Use this command to list the machines and get their IP addresses.

    docker-machine ls

Here is example output from this command.

    NAME    ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER        ERRORS
    myvm1   -        virtualbox   Running   tcp://192.168.99.100:2376           v17.06.2-ce
    myvm2   -        virtualbox   Running   tcp://192.168.99.101:2376           v17.06.2-ce

### INITIALIZE THE SWARM AND ADD NODES ###

TODO

## Useful links ##

[Docker documentation page](https://docs.docker.com/get-started/part4/)

| Navigation               |
| ------------------------ |
| [Level up](../README.md) |
