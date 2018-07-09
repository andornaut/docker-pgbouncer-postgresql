# docker-pgbouncer-postgresql

Dockerized [PostgreSQL](https://www.postgresql.org/) server with the [PgBouncer](https://pgbouncer.github.io/)
connection pooler.

## Usage

PgBouncer is bound to port 6432. PostgreSQL is bound to port 5432.

```bash
# Start service
docker-compose up --build

# Connect using the psql client from within the container
docker-compose exec pgbouncer-postgresql \
    psql --user postgres postgres

# Connect using psql client on the Docker host
psql -h localhost -p 6432
```

If you specify `$DB_NAME`, `$DB_USER`, and `$DB_PASS` environment variables
and if there is no existing database data, then a user and database will be
created the first time you start the container.

### Connecting to the admin console

[Documentation](https://pgbouncer.github.io/usage.html#admin-console)

```bash
docker-compose exec --user postgres pgbouncer-postgresql \
    psql --user pgbouncer --port 6432 pgbouncer
```
