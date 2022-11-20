#!/usr/bin/env bash

set -e

readonly TRUNCATE_TABLE_SCRIPT="truncate_db_table.sql"
readonly CREATE_DB_SUPERUSER="create_db_superuser.sql"

DB_USER="colludeadmin"
DB_PASS="postgres"
DB_NAME="collude_db"

main() {
    echo_yellow "Run DB..."
    docker-compose up -d db
    echo_yellow "🔎 Getting ID of DB container..."
    DB_ID=$(docker-compose ps -q db)
    echo_blue "DB Container ID $DB_ID"
    echo_yellow "🧨 Removing existing database..."
    docker cp "provision/docker/api/scripts/$TRUNCATE_TABLE_SCRIPT" "$DB_ID:/tmp/$TRUNCATE_TABLE_SCRIPT"
    docker-compose exec -T db bash -c "psql -U postgres --set 'DB_USER=$DB_USER' --set 'DB_NAME=$DB_NAME' --set 'DB_PASS=$DB_PASS' -f /tmp/$TRUNCATE_TABLE_SCRIPT"
    docker-compose exec -T db bash -c "rm /tmp/$TRUNCATE_TABLE_SCRIPT"

    #TODO: RESTORE SOME BASE TABLE DATA EVENTUALLY HERE.
    # echo_yellow "Restoring postgres superuser..."
    # docker cp "provision/docker/api/scripts/$CREATE_DB_SUPERUSER" "$DB_ID:/tmp/$CREATE_DB_SUPERUSER"
    # docker-compose exec -T db bash -c "psql -U postgres --set 'DB_USER=$DB_USER' --set 'DB_NAME=$DB_NAME' --set 'DB_PASS=$DB_PASS' -f /tmp/$CREATE_DB_SUPERUSER"
    # docker-compose exec -T db bash -c "rm /tmp/$CREATE_DB_SUPERUSER"
    # echo_green "Postgres SuperUser Restored!"
    echo_green "🚀 Database refreshed successfully!"


}

source bin/shell-helpers.sh
main