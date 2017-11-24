# Docker / Quick start #

## Install ##

TODO

## Check version ##

Run:

    docker --version

## Check installation ##

Run:

    docker run hello-world

## Create Dockerfile ##

Run the following:

    mkdir quick-start-app
    cd quick-start-app

And create **Dockerfile** with the following content there:

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

TODO

| Navigation               |
| ------------------------ |
| [Level up](../README.md) |
