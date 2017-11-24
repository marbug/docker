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

## Create app files ##

In the same folder with the **Dockerfile**.

### requirements.txt ###

    Flask
    Redis

### app.py ###

    from flask import Flask
    from redis import Redis, RedisError
    import os
    import socket

    # Connect to Redis
    redis = Redis(host="redis", db=0, socket_connect_timeout=2, socket_timeout=2)

    app = Flask(__name__)

    @app.route("/")
    def hello():
        try:
            visits = redis.incr("counter")
        except RedisError:
            visits = "<i>cannot connect to Redis, counter disabled</i>"

        html = "<h3>Hello {name}!</h3>" \
               "<b>Hostname:</b> {hostname}<br/>" \
               "<b>Visits:</b> {visits}"
        return html.format(name=os.getenv("NAME", "world"), hostname=socket.gethostname(), visits=visits)

    if __name__ == "__main__":
        app.run(host='0.0.0.0', port=80)

## Build the app ##

    docker build -t friendlyhello .

Check

    docker images

or

    docker image ls

## Run the app ##

Run the app, mapping your machine’s port 4000 to the container’s published port 80 using **-p**:

    docker run -p 4000:80 friendlyhello

And open [http://localhost:4000](http://localhost:4000) in your browser.

## Stop the app ##

Hit **CTRL+C** in your terminal to quit.

## Run the app in background ##

    docker run -d -p 4000:80 friendlyhello

Check

    docker container ls

### Stop the background app ###

Now use **docker container stop** to end the process, using the **CONTAINER ID**, like so:

    docker container stop 01cb7916182c

TODO

| Navigation               |
| ------------------------ |
| [Level up](../README.md) |
