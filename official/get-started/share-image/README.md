# Docker / Get started / Share image #

To demonstrate the portability of what we just created, let’s upload our built image and run it somewhere else. After all, you’ll need to learn how to push to registries when you want to deploy containers to production.

A registry is a collection of repositories, and a repository is a collection of images—sort of like a GitHub repository, except the code is already built. An account on a registry can create many repositories. The **docker** CLI uses Docker’s public registry by default.

**Note:** We’ll be using Docker’s public registry here just because it’s free and pre-configured, but there are many public ones to choose from, and you can even set up your own private registry using [Docker Trusted Registry](TODO).

## Log in with your Docker ID ##

If you don’t have a Docker account, sign up for one at [cloud.docker.com](https://cloud.docker.com/). Make note of your username.

Log in to the Docker public registry on your local machine.

    docker login

TODO

## Useful links ##

[Docker documentation page](https://docs.docker.com/get-started/part2/#share-your-image)

| Navigation               |
| ------------------------ |
| [Level up](../README.md) |
