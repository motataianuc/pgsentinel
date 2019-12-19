
export PG_VERSION=11
export PG_DATADIR="/etc/postgresql/${PG_VERSION}/main"
./install_postgresql.sh
./install_pgsentinel.sh
./configure_postgresql.sh
./start_postgresql.sh
test "x$PG_VERSION" != 'xHEAD' || psql -U postgres -c "set password_encryption='scram-sha-256'; create user test with password 'test';"
test "x$PG_VERSION" = 'xHEAD' || psql -U postgres -c "create user test with password 'test';"
psql -U postgres -c "CREATE EXTENSION pgsentinel;"
psql -c 'create database test owner test;' -U postgres