#!/bin/bash
set -x
echo "DO: patch $(find /usr -type f -name tms_demo.html) tms_demo.patch"
patch $(find /usr -type f -name tms_demo.html) tms-demo.patch

echo "DO: patch  $(find /usr -type f -name wmts_demo.html) wmts_demo.patch"
patch $(find /usr -type f -name wmts_demo.html) wmts-demo.patch
