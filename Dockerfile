FROM python:3.11-slim-bookworm

# Notes by Just van den Broecke
# July 2020
# The original image (from 2019), based on Debian Buster Python3 was around 1GB.
# Slimmed down to 294MB by:
# - using Debian Slim image.
# - Using https://github.com/geopython/pygeoapi/blob/master/Dockerfile as example.
# - avoided building wheels by installing python- packages
# - removing build dependency packages.
#
# Upgrade notes: Debian bullseye-slim (follow up from Buster) has Python 3.8
# Currently compat problem with MP 1.12.0 because of "cgi" packages
# See issue: https://github.com/mapproxy/mapproxy/issues/462
# like wsgi-plugin-python3 (needs to wait)
#
# Upgrade notes: in bullseye: use libproj19 uwsgi-plugin-python3 (i.s.o. pip3 uwsgi)
# --plugin /usr/lib/uwsgi/plugins/python3_plugin.so in uwsgi command and remove --wsgi-disable-file-wrapper

# May 2024
# * Python 3.11 and MapProxy 2.0.2
# * upgrade Base image to python:3.11-slim-bookworm
# * drop support for EPSG:900913
# * patch TMS demo HTML
# * uwsgi from python3-uwsgi i.s.o. PyPi/pip: no build deps needed!
# * ENV settings: PROJ_DATA and PYTHONPATH

LABEL original_developer="Arne Schubert <atd.schubert@gmail.com>"
LABEL contributor="Just van den Broecke <justb4@gmail.com>"

# Build ARGS
ARG TZ="Europe/Amsterdam"
ARG LOCALE="en_US.UTF-8"
# Only adds 1MB and handy tools
ARG ADD_DEB_PACKAGES="curl xsltproc libxml2-utils patch"
ARG ADD_PIP_PACKAGES=""
ARG MAPPROXY_VERSION="2.0.2"

# ENV settings
ENV MAPPROXY_PROCESSES="4" \
	MAPPROXY_THREADS="2" \
	UWSGI_EXTRA_OPTIONS="" \
	DEBIAN_FRONTEND="noninteractive" \
	PROJ_DATA="/usr/share/proj" \
	PYTHONPATH="/usr/lib/python3/dist-packages:/usr/local/lib/python3.11/site-packages" \
	DEB_PACKAGES="python3-pil python3-yaml python3-pyproj libgeos-dev python3-lxml libgdal-dev python3-shapely libxml2-dev libxslt-dev uwsgi uwsgi-plugin-python3 ${ADD_DEB_PACKAGES}" \
	PIP_PACKAGES="requests geojson watchdog MapProxy==${MAPPROXY_VERSION} ${ADD_PIP_PACKAGES}"

RUN set -x \
  && apt update \
  && apt install --no-install-recommends -y ${DEB_PACKAGES} ${ADD_DEB_PACKAGES} \
  && useradd -ms /bin/bash mapproxy \
  && mkdir -p /mapproxy \
  && chown mapproxy /mapproxy \
  && pip3 install ${PIP_PACKAGES} ${ADD_PIP_PACKAGES} \
  && mkdir -p /docker-entrypoint-initmapproxy.d \
  && pip3 uninstall --yes wheel \
  && pip3 cache purge \
  && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
  && apt-get --yes --purge autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY patches/ /patches
RUN cd /patches && ./apply.sh && cd -

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["mapproxy"]

USER mapproxy

# Why needed? See examples.
# VOLUME ["/mapproxy"]
EXPOSE 8080
# Stats
EXPOSE 9191
