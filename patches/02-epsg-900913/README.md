# Skipped
Skipping this patch starting with 1.16.0 version. 
Skipping in [apply.sh](apply.sh), but keeping the fix if ever needed.

## What this solved
Nasty fix: append proj Google Web Merc projection EPSG:900913
to /usr/share/proj/epsg for legacy MP configs (clients use /EPSG:900913/ in URLs!)
Upgrade notes: Debian bullseye-slim and proj.6: will 
need SQLite for proj.db i.s.o. /usr/share/proj/epsg!!
