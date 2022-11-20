#!/usr/bin/env bash

set -e

main() {
    echo_blue "👷 Creating Django superuser.."
    docker-compose run --rm web ./manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('$DJANGO_SUPERUSER_USERNAME', '$DJANGO_SUPERUSER_EMAIL', '$DJANGO_SUPERUSER_PASSWORD')"
    echo_blue "🎉 Django superuser created!"
}

source bin/shell-helpers.sh
source .env
main