#!/bin/bash
set -x
echo "DO: patch /usr/local/lib/python3.11/site-packages/mapproxy/service/templates/demo/tms_demo.html tms_demo.patch"
patch $(find /usr -type f -name tms_demo.html) tms-demo.patch
