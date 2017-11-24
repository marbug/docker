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

This **Dockerfile** refers to a couple of files we haven’t created yet, namely **app.py** and **requirements.txt**. Let’s create those next.

### The app itself ###

Create two more files, **requirements.txt** and **app.py**, and put them in the same folder with the **Dockerfile**. This completes our app, which as you can see is quite simple. When the above **Dockerfile** is built into an image, **app.py** and **requirements.txt** will be present because of that **Dockerfile**’s **ADD** command, and the output from **app.py** will be accessible over HTTP thanks to the **EXPOSE** command.

#### requirements.txt ####

    Flask
    Redis

#### app.py ####

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

### About app code ###

Now we see that **pip install -r requirements.txt** installs the Flask and Redis libraries for Python, and the app prints the environment variable **NAME**, as well as the output of a call to **socket.gethostname()**. Finally, because Redis isn’t running (as we’ve only installed the Python library, and not Redis itself), we should expect that the attempt to use it here will fail and produce the error message.

**Note:** Accessing the name of the host when inside a container retrieves the container ID, which is like the process ID for a running executable.

That’s it! You don’t need Python or anything in **requirements.txt** on your system, nor will building or running this image install them on your system. It doesn’t seem like you’ve really set up an environment with Python and Flask, but you have.

### Build the app ###

Now run the build command. This creates a Docker image, which we’re going to tag using **-t** so it has a friendly name.

    docker build -t friendlyhello .

Where is your built image? It’s in your machine’s local Docker image registry:

    docker images

**Tip:** You can use the commands docker images or the newer **docker image ls** list images. They give you the same output.

### Run the app ###

Run the app, mapping your machine’s port 4000 to the container’s published port 80 using **-p**:

    docker run -p 4000:80 friendlyhello

You should see a message that Python is serving your app at [http://0.0.0.0:80](http://0.0.0.0:80). But that message is coming from inside the container, which doesn’t know you mapped port 80 of that container to 4000, making the correct URL [http://localhost:4000](http://localhost:4000).

Go to that URL in a web browser to see the display content served up on a web page, including “Hello World” text, the container ID, and the Redis error message.

**Note:** If you are using Docker Toolbox on Windows 7, use the Docker Machine IP instead of localhost. For example, [http://192.168.99.100:4000/](http://192.168.99.100:4000/). To find the IP address, use the command **docker-machine ip**.

## TODO ##

TODO

## Useful links ##

[Docker documentation page](https://docs.docker.com/get-started/part2/)

| Navigation               |
| ------------------------ |
| [Level up](../README.md) |
