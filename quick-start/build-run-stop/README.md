# Docker / Quick start / Build, run, stop #

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

| Navigation               |
| ------------------------ |
| [Level up](../README.md) |
