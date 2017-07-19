FROM postgres:9.6

# 5432 is exposed by the base image.
# 6432 is used by PgBouncer
EXPOSE 6432

ENV POSTGRES_DB=postgres \
    POSTGRES_GROUP=postgres \
    POSTGRES_USER=postgres

RUN apt-get -qq update \
	&& DEBIAN_FRONTEND=noninteractive apt-get -qq install --no-install-recommends \
	pgbouncer \
	postgresql-client-common \
	python-psycopg2 \
	&& rm -rf /var/lib/apt/lists/*

# Disambiguate: The base image adds a file named docker-entrypoint.sh
COPY ["docker-entrypoint-custom.sh", "/"]

COPY ["docker-entrypoint-initdb.d", "/docker-entrypoint-initdb.d/"]
COPY ["pgbouncer.ini", "/etc/pgbouncer/"]

RUN mkdir /var/log/pgbouncer/ /var/run/pgbouncer/ \
    && chown -R ${POSTGRES_USER}:${POSTGRES_GROUP} /etc/pgbouncer/ /var/log/pgbouncer/ /var/run/pgbouncer/

ENTRYPOINT ["/docker-entrypoint-custom.sh"]

CMD ["postgres"]
