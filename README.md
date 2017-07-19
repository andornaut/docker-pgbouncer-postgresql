# docker-pgbouncer-postgresql

Dockerized [PostgreSQL](https://www.postgresql.org/) server with a [PgBouncer](https://pgbouncer.github.io/)
connection pooler.

## Usage

PgBouncer is bound to port 6432. PostgreSQL is bound to port 5432.

```
# Start service
docker-compose up --build

# Connect using the psql client from within the container
docker-compose exec pgbouncer-postgresql psql -U postgres postgres

# Connect to the port that PgBouncer is listening on
psql -h localhost -p 6432
```

If you specify `$DB_NAME`, `$DB_USER`, and `$DB_PASS` environment variables
and if there is no existing database data, then a user and database will be
created the first time you start the container.
