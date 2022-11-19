#!/usr/bin/env bash
source bin/shell-helpers.sh
set -e 

echo_yellow "👷 Building Collude_API Container..."

docker build \
-f provision/docker/api/Dockerfile \
-t collude_api \
.

echo_green "🚀 Collude_API Container Built Successfully!"

echo_yellow "👷 Starting Local.."

docker-compose up -d --build

echo_green "🚀 Local Containers Are Running!"

#create default superuser
bash bin/create-superuser.sh

