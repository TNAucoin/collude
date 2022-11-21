#!/bin/bash
set -e


cd $APP_ROOT
python manage.py makemigrations
python manage.py migrate --noinput
python manage.py runserver 0.0.0.0:8000


exec $@