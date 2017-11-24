# Docker / Get started / Containers #

## Introduction ##

It’s time to begin building an app the Docker way. We’ll start at the bottom of the hierarchy of such an app, which is a container, which we cover on this page. Above this level is a service, which defines how containers behave in production, covered [here](TODO). Finally, at the top level is the stack, defining the interactions of all the services, covered [here](TODO).

## Your new development environment ##

n the past, if you were to start writing a Python app, your first order of business was to install a Python runtime onto your machine. But, that creates a situation where the environment on your machine has to be just so in order for your app to run as expected; ditto for the server that runs your app.

With Docker, you can just grab a portable Python runtime as an image, no installation necessary. Then, your build can include the base Python image right alongside your app code, ensuring that your app, its dependencies, and the runtime, all travel together.

These portable images are defined by something called a *Dockerfile*.

## Define a container with a Dockerfile ##

*Dockerfile* will define what goes on in the environment inside your container. Access to resources like networking interfaces and disk drives is virtualized inside this environment, which is isolated from the rest of your system, so you have to map ports to the outside world, and be specific about what files you want to “copy in” to that environment. However, after doing that, you can expect that the build of your app defined in this Dockerfile will behave exactly the same wherever it runs.

### Dockerfile ###

Create an empty directory. Change directories (**cd**) into the new directory, create a file called **Dockerfile**, copy-and-paste the following content into that file, and save it. Take note of the comments that explain each statement in your new Dockerfile.

    # Use an official Python runtime as a parent image
    FROM python:2.7-slim

    # Set the working directory to /app
    WORKDIR /app

    # Copy the current directory contents into the container at /app
    ADD . /app

    # Install any needed packages specified in requirements.txt
    RUN pip install --trusted-host pypi.python.org -r requirements.txt

    # Make port 80 available to the world outside this container
    EXPOSE 80

    # Define environment variable
    ENV NAME World

    # Run app.py when the container launches
    CMD ["python", "app.py"]

## TODO ##

TODO

## Useful links ##

[Docker documentation page](https://docs.docker.com/get-started/part2/)

| Navigation               |
| ------------------------ |
| [Level up](../README.md) |
