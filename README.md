# c2s-ipython-docker
Dockerfile for the [c2s toolbox](https://github.com/lucastheis/c2s) with IPython support.

The image is available as an automated build on [Docker Hub](https://registry.hub.docker.com/u/jonasrauber/c2s-ipython/).

If you don't need IPython, consider using [c2s-docker](https://github.com/jonasrauber/c2s-docker) instead.

## How to use

*Please note that you might need to prefix all docker commands with `sudo` depending on your docker setup.*

After installing [Docker](https://www.docker.com/), get the `c2s-ipython` Docker image:

```sh
docker pull jonasrauber/c2s-ipython
```

Alternatively, you can build the image yourself, however the build process may take some time.

```sh
docker build --rm -t jonasrauber/c2s-ipython https://github.com/jonasrauber/c2s-ipython-docker.git
```

You can than use it similar to the [ipython/scipyserver docker image](https://registry.hub.docker.com/u/ipython/scipyserver/).

```sh
docker run -it --rm -p 443:8888 -e "PASSWORD=MakeAPassword" -v "$PWD:/notebooks" jonasrauber/c2s-ipython
```

You should than be able to reach the IPython notebook at https://hostname. Please change the password. You might choose another port instead of 443. If you don't want to use HTTPS, set the `USE_HTTP` environment variable `-e "USE_HTTP=1"`.

```sh
docker run -it --rm -p 80:8888 -e "PASSWORD=MakeAPassword" -e "USE_HTTP=1" -v "$PWD:/notebooks" jonasrauber/c2s-ipython
```

To get more information on `c2s` itself, have a look at the [c2s repository](https://github.com/lucastheis/c2s) and the [c2s documentaiton](http://c2s.readthedocs.org/en/latest/).

### c2s visualize workaround

`c2s visualize` from within a Docker container requires a workaround as described in [issue #3](https://github.com/jonasrauber/c2s-docker/issues/3).

The following steps work on OS X:

```sh
brew install socat
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
# in another window
docker run -it --rm -e DISPLAY=192.168.1.2:0 -v $PWD:/data/workdir jonasrauber/c2s visualize data.0.mat
```
The ip address 192.168.1.2 needs to be replaced with the respective host ip (i.e. the ip of OS X).

