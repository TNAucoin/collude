.ONESHELL:
reset-superuser: SHELL := python
reset-superuser:
	import os 
	import django
	from django.contrib.auth import get_user_model

	os.environ.setdefault("DJANGO_SETTINGS_MODULE", "settings.develop")
	django.setup()

	User = get_user_model()
	user = User.objects.filter(is_superuser=True).first()

	if user:
		user.set_password("admin")
		user.save()
	else:
		user = User.objects.create_superuser(
			username="josuedjh",
			first_name="Josue djh",
			password="admin",
		)

	print(f"Superuser {user.username!r} with password `admin`")