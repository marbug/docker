# Docker / Get started / Stacks #

## Prerequisites ##

* Make sure that the machines you set up in part 4 are running and ready. Run **docker-machine ls** to verify this. If the machines are stopped, run **docker-machine start myvm1** to boot the manager, followed by **docker-machine start myvm2** to boot the worker.

* Have the swarm you created in [part 4 (Swarms)](../swarms/README.md) running and ready. Run **docker-machine ssh myvm1 "docker node ls"** to verify this. If the swarm is up, both nodes will report a **ready** status. If not, reinitialze the swarm and join the worker as described in [Set up your swarm](../swarms/README.md).

TODO

## Useful links ##

[Docker documentation page](https://docs.docker.com/get-started/part5/)

| Navigation               |
| ------------------------ |
| [Level up](../README.md) |
