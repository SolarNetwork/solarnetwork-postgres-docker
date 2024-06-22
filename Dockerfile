FROM postgres:12 AS buildenv

RUN apt-get update

RUN apt-get install -y --no-install-recommends postgresql-server-dev-12 libkrb5-dev

RUN apt-get install -y --no-install-recommends ca-certificates git

RUN apt-get install -y --no-install-recommends build-essential gcc g++ cmake

RUN <<EOF bash
mkdir -p /src
cd /src
git clone https://github.com/timescale/timescaledb.git
git clone https://github.com/pjungwir/aggs_for_vecs.git
git clone https://github.com/SolarNetwork/solarnetwork-central.git
EOF

FROM buildenv AS build
# Build Timescale
RUN <<EOF bash
cd /src/timescaledb
git checkout 2.10.1
./bootstrap
cd build
make
make install DESTDIR=/stage
EOF

# Build aggs_for_vecs
RUN <<EOF bash
cd /src/aggs_for_vecs
git checkout v1.3.0
make
make install DESTDIR=/stage
EOF

# Get latest development DB setup
RUN <<EOF bash
cd /src/solarnetwork-central
git checkout develop
EOF

# Copy extensions into final image
FROM postgres:12

COPY --from=build /stage /

COPY --from=build /src/solarnetwork-central/solarnet-db-setup/postgres /usr/local/share/solarnet-db-setup

COPY setup.sh /docker-entrypoint-initdb.d
