# collectd-crashplan
[Collectd](https://collectd.org/) plugin for collecting Crashplan statistics.

Collects information (total file count, total file size, percentage completed) from the crashplan app log.
Implemented as a bash script.

## Requirements
* bash
* [GNU bc](https://www.gnu.org/software/bc/) or some other POSIX-compatible version of bc.

## Installation
Install the script in any location.

## Configuration
The [exec](https://collectd.org/documentation/manpages/collectd-exec.5.shtml) plugin must be loaded in *collectd.conf*.
The exec plugin is configured with a username (to run the script), path to the script and path to the crashplan app.log.

```
LoadPlugin exec
<Plugin exec>
        Exec username "/usr/local/bin/collectd_crashplan.sh" "/usr/local/crashplan/log/app.log"
</Plugin>
```

