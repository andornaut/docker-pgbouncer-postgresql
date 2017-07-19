#!/bin/bash
set -e

#
# Configure and start pgbouncer
#

configfile=/etc/pgbouncer/pgbouncer.ini
userfile=/etc/pgbouncer/userlist.txt
logfile=/var/log/pgbouncer/pgbouncer.log
pidfile=/var/run/pgbouncer/pgbouncer.pid

echo "Creating pgbouncer userlist"
/usr/share/pgbouncer/mkauth.py "${userfile}" "dbname='postgres' user='${POSTGRES_USER}' host='localhost'"

touch "${logfile}"
chmod 644 "${configfile}"
chmod 644 "${userfile}"

# The user who runs this script varies between first run and subsequent runs.
command="/usr/sbin/pgbouncer --daemon ${configfile}"
if [[ "$(whoami)" = "${POSTGRES_USER}" ]]; then
    ${command} &
else
    gosu ${POSTGRES_USER} ${command} &
fi
