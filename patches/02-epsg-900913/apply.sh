#!/bin/bash
set -x
echo "SKIP: patch for EPSG:900913 support"

# GOOGLE_WEB_MERC_EPSG="<900913> +proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +wktext +no_defs <>"
# echo "${GOOGLE_WEB_MERC_EPSG}" >> /usr/share/proj/epsg
