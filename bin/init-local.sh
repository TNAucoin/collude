#!/usr/bin/env bash
source bin/shell-helpers.sh
set -e 

# Setup Env file
echo_yellow "👷 Setting up env"
if [ -f ./.env ]; then
    mv "./.env" "./.env.backup"
    echo_blue "🛟 existing .env file backed up!"
fi

cat "./example.env" >> "./.env"
echo_green "🎉 new .env file generated with defaults!"

# Build api container
echo_yellow "👷 Building Collude_API Container..."

docker build \
--quiet \
-f provision/docker/api/Dockerfile \
-t collude_api \
.

echo_green "🚀 Collude_API Container Built Successfully!"

# Refresh DB
echo_yellow "👷 Refreshing Database..."
bash bin/refresh-local-db.sh

# Start Api services
echo_yellow "👷 Starting Local.."

docker-compose up -d --build

# Create default superuser
bash bin/create-superuser.sh

echo_green "🚀 Local Containers Are Running!"

