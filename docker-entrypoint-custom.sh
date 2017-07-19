#!/bin/bash

if [[ "$1" = "postgres" && -s "${PGDATA}/PG_VERSION" ]]; then
	chown -R ${POSTGRES_USER}:${POSTGRES_GROUP} "${PGDATA}"
	chmod -R go-rwx "${PGDATA}"
	gosu ${POSTGRES_USER} pg_ctl -D "${PGDATA}" -o "-c listen_addresses='localhost'" -w start

	./docker-entrypoint-initdb.d/0-create-user-and-db.sh
	./docker-entrypoint-initdb.d/1-pgbouncer.sh

	gosu ${POSTGRES_USER} pg_ctl -D "${PGDATA}" -m fast -w stop
fi

exec /docker-entrypoint.sh $@
