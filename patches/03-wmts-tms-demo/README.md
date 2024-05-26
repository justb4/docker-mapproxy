# What this solves
The TMS demo code uses the OpenLayers XYZ class (i.s.o. TMS) class after the OL upgrade.
But the TMS service needs the `/1.0.0/` string in its path and custom tilegrid settings.

This patches the code for the TMS demo HTML template: 
[mapproxy/service/templates/demo/tms_demo.html](tms_demo-2.0.2.html).

Also: Using tile size from the grid i.s.o. the default 256x256 in the WMTS demo HTML template 
for [mapproxy/service/templates/demo/wmts_demo.html](wmts_demo-2.0.2.html).

# Related PR

See https://github.com/mapproxy/mapproxy/pull/931 . 
Once this is available in a version, this patch can be removed.

# Commands

The version from `master` fetched on May 24, 2024 which is the version in MapProxy 2.0.2.

TMS:
``` 
diff -u tms_demo-2.0.2.html tms_demo-patched.html  > tms-demo.patch

# to be independent of Python version and MP install location
patch $(find /usr -type f -name tms_demo.html) tms-demo.patch
```


WMTS:
``` 
diff -u wmts_demo-2.0.2.html wmts_demo-patched.html  > wmts-demo.patch

# to be independent of Python version and MP install location
patch $(find /usr -type f -name wmts_demo.html) wmts-demo.patch
```