# Docker / Get started / Share image #

## Log in with your Docker ID ##

    docker login

## Tag the image ##

The notation for associating a local image with a repository on a registry is **username/repository:tag**. The tag is optional, but recommended, since it is the mechanism that registries use to give Docker images a version.

    docker tag image username/repository:tag

For example:

    docker tag friendlyhello john/get-started:part2

Check:

    docker images

or

    docker image ls

## Publish the image ##

    docker push username/repository:tag

For example:

    docker push john/get-started:part2

Once complete, the results of this upload are publicly available. If you log in to [Docker Hub](https://hub.docker.com/), you will see the new image there, with its pull command.

## Pull and run the image from the remote repository ##

    docker run -p 4000:80 username/repository:tag

For example:

    docker run -p 4000:80 john/get-started:part2

If the image isn’t available locally on the machine, Docker will pull it from the repository.

**Note:** If you don’t specify the **:tag** portion of these commands, the tag of **:latest** will be assumed.

## Useful links ##

[Docker documentation page](https://docs.docker.com/get-started/part2/#share-your-image)

| Navigation               |
| ------------------------ |
| [Level up](../README.md) |
