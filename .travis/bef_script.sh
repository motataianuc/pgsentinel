#!/usr/bin/env bash
set -x -e

export PG_VERSION=11
export PG_DATADIR="/etc/postgresql/${PG_VERSION}/main"
cd /pgsentinel
.travis/install_postgresql.sh
.travis/install_pgsentinel.sh
.travis/configure_postgresql.sh
.travis/start_postgresql.sh
test "x$PG_VERSION" != 'xHEAD' || psql -U postgres -c "set password_encryption='scram-sha-256'; create user test with password 'test';"
test "x$PG_VERSION" = 'xHEAD' || psql -U postgres -c "create user test with password 'test';"
psql -U postgres -c "CREATE EXTENSION pgsentinel;"
psql -c 'create database test owner test;' -U postgres