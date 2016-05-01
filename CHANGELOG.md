1.1.0 (2016-05-02)
----
- Added script which downloads and extracts required files for xenial netboot.
- The used basebox uses Puppet 4 now, which broke everything. This is fixed now.
- Added rsyslog config to let dnsmasq log to `/var/log/daemon.log` which makes debugging easier.
- Stopped using NFS for shared folders which should make it more usable for Windows users. Also on Mac OS X this can be quite a hassle.
- Added demo to README.md

1.0.0 (2015-02-07)
----
Initial release
