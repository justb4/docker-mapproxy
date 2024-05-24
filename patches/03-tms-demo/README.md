# What this solves
The TMS demo code uses the OpenLayers XYZ class (i.s.o. TMS) class after the OL upgrade.
But the TMS service needs the `/1.0.0/` string in its path.
This adds that path element to the TMS demo HTML template.

# commands

The version from `master` fetched on May 24, 2024 which is the version in MapProxy 2.0.2.

``` 
diff -u tms_demo-2.0.2.html tms_demo-patched.html  > tms-demo.patch
patch /usr/local/lib/python3.11/site-packages/mapproxy/service/templates/demo/tms_demo.html tms-demo.patch

# or better
patch $(find /usr -type f -name tms_demo.html) tms-demo.patch
```