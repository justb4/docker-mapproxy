# MapProxy for Docker

![GitHub license](https://img.shields.io/github/license/justb4/docker-mapproxy)
![GitHub release](https://img.shields.io/github/release/justb4/docker-mapproxy.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/justb4/mapproxy.svg)

MapProxy Docker Image from the [YAGA Development-Team](https://github.com/yagajs).
Adapted by [justb4](https://github.com/justb4) to latest MP version, small Docker image and extended examples.
Find image on [Docker Hub](https://hub.docker.com/repository/docker/justb4/mapproxy).

## Supported tags

See  [Docker Hub](https://hub.docker.com/repository/docker/justb4/mapproxy)

## What is MapProxy

[MapProxy](https://mapproxy.org/) is an open source proxy for geospatial data. It caches, accelerates and transforms
data from existing map services and serves any desktop or web GIS client.

## Run container

See the examples, these use `docker-compose`, more convenient than `docker run` commands:

* [default](examples/default) - default out-of-the-box example
* [standard](examples/standard) - mapproxy [config](examples/standard/config/mapproxy.yaml) with some facilities like GeoPackage tile cache, custom grid etc

The second example should give you a nice starter.

But you can run the container with standard `docker`:

```bash
docker run -v /path/to/mapproxy:/mapproxy -p 8080:8080 justb4/mapproxy
```

*It is optional, but recommended to add a volume. Within the volume mapproxy get the configuration, or create one
automatically. Cached tiles will be stored also into this volume.*

The container normally runs in [http-socket-mode](http://uwsgi-docs.readthedocs.io/en/latest/HTTP.html). If you are not
running the image behind an HTTP-Proxy, like [Nginx](http://nginx.org/), you should run it in direct `http-mode` by running:

```bash
docker run -v /path/to/mapproxy:/mapproxy -p 8080:8080 justb4/mapproxy mapproxy http
```

### Environment variables

* `MAPPROXY_PROCESSES` default: 4
* `MAPPROXY_THREADS` default: 2
* `UWSGI_EXTRA_OPTIONS` extra `uwsgi` commandline options e.g. `"--disable-logging --stats 0.0.0.0:9191"`, default empty

### Run as local user

In some cases, especially when using mounted volumes, you may get permission issues on directories and (log-) files.
You can also have the Docker Container run as your local user (id) i.s.o. `mapproxy`. But never run as user root!

In a `docker-compose.yml` you may set: `user: ${HOST_UID_GID}`. This env var can be generated: `export HOST_UID_GID="$(id -u):$(id -g)"`, in your
local environment or a start script. 

See the [docker-compose.yml in examples/standard](examples/standard/docker-compose.yml) and 
[start.sh there](examples/standard/start.sh). 

## Seeding

The image also allows arbitrary commands like for seeding:

```bash 

docker exec -it mapproxy mapproxy-seed -f /mapproxy/mapproxy.yaml -s /mapproxy/seed.yaml --seed myseed1

```

## Proj Version Info

Proj in `/usr/lib` from `python3-proj` package.

```
$ /usr/bin/pyproj -v

pyproj info:
    pyproj: 3.4.1
      PROJ: 9.1.1
  data dir: /usr/share/proj
user_data_dir: /tmp/proj
PROJ DATA (recommended version): 1.12
PROJ Database: 1.2
EPSG Database: v10.076 [2022-08-31]
ESRI Database: ArcGIS Pro 3.0 [2022-07-09]
IGNF Database: 3.1.0 [2019-05-24]

System:
    python: 3.11.2 (main, Mar 13 2023, 12:18:29) [GCC 12.2.0]
executable: /usr/bin/python3
   machine: Linux-6.6.22-linuxkit-aarch64-with-glibc2.36

Python deps:
   certifi: 2022.9.24
    Cython: None
setuptools: None
       pip: None

```
## Enhance the image

You can put a `mapproxy.yaml` into the `/docker-entrypoint-initmapproxy.d` folder on the image. On startup this will be
used as MapProxy configuration. Attention, this will override an existing configuration in the volume!

In addition, you can put shell-scripts, with `.sh`-suffix in that folder. They get executed on container startup.

You should use the `mapproxy` user within the container, especially not `root`!

You can also add extra packages in build args: `ADD_DEB_PACKAGES` and `ADD_PIP_PACKAGES`.

## Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull
requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a
[GitHub issue](https://github.com/justb4/docker-mapproxy/issues), especially for more ambitious contributions.
This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help
you find out if someone else is working on the same thing.

## License

This project is published under [ISC License](LICENSE).
