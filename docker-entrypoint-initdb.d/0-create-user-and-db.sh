#!/bin/bash

if [[ -z "${DB_NAME}" || -z "${DB_USER}" || -z "${DB_PASS}" ]]; then
	echo "\$DB_NAME, \$DB_USER and \$DB_PASS environment variables are not set." >&2
	echo "Skipping user and database creation." >&2
else
	echo "Creating user: ${DB_USER}"
	echo "Creating database: ${DB_NAME}"

	psql -v ON_ERROR_STOP=0 --username "${POSTGRES_USER}" <<-EOL
		CREATE USER ${DB_USER};
		ALTER USER ${DB_USER} WITH PASSWORD '${DB_PASS}';
		CREATE DATABASE ${DB_NAME} OWNER ${DB_USER};
	EOL
fi
