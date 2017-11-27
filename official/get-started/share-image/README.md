# Docker / Get started / Share image #

To demonstrate the portability of what we just created, let’s upload our built image and run it somewhere else. After all, you’ll need to learn how to push to registries when you want to deploy containers to production.

A registry is a collection of repositories, and a repository is a collection of images—sort of like a GitHub repository, except the code is already built. An account on a registry can create many repositories. The **docker** CLI uses Docker’s public registry by default.

**Note:** We’ll be using Docker’s public registry here just because it’s free and pre-configured, but there are many public ones to choose from, and you can even set up your own private registry using [Docker Trusted Registry](TODO).

## Log in with your Docker ID ##

If you don’t have a Docker account, sign up for one at [cloud.docker.com](https://cloud.docker.com/). Make note of your username.

Log in to the Docker public registry on your local machine.

    docker login

## Tag the image ##

The notation for associating a local image with a repository on a registry is **username/repository:tag**. The tag is optional, but recommended, since it is the mechanism that registries use to give Docker images a version. Give the repository and tag meaningful names for the context, such as **get-started:part2**. This will put the image in the **get-started** repository and tag it as **part2**.

Now, put it all together to tag the image. Run **docker tag image** with your username, repository, and tag names so that the image will upload to your desired destination. The syntax of the command is:

    docker tag image username/repository:tag

For example:

    docker tag friendlyhello john/get-started:part2

Run **docker images** to see your newly tagged image. (You can also use **docker image ls**.)

## Publish the image ##

Upload your tagged image to the repository:

    docker push username/repository:tag

For example:

    docker push john/get-started:part2

Once complete, the results of this upload are publicly available. If you log in to [Docker Hub](https://hub.docker.com/), you will see the new image there, with its pull command.

## Pull and run the image from the remote repository ##

From now on, you can use **docker run** and run your app on any machine with this command:

    docker run -p 4000:80 username/repository:tag

For example:

    docker run -p 4000:80 john/get-started:part2

If the image isn’t available locally on the machine, Docker will pull it from the repository.

**Note:** If you don’t specify the **:tag** portion of these commands, the tag of **:latest** will be assumed, both when you build and when you run images. Docker will use the last version of the image that ran without a tag specified (not necessarily the most recent image).

No matter where **docker run** executes, it pulls your image, along with Python and all the dependencies from **requirements.txt**, and runs your code. It all travels together in a neat little package, and the host machine doesn’t have to install anything but Docker to run it.

## Useful links ##

[Docker documentation page](https://docs.docker.com/get-started/part2/#share-your-image)

| Navigation               |
| ------------------------ |
| [Level up](../README.md) |
