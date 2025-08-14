# Rulikkk's blog

This repository contains the source code of my blog — https://rmust.me

This is a fork of Vastrik' blog. Thank you!

> It is completely custom and is not intended to be used as a universal blog engine. I keep his code here purely because why not. Open Source FTW!
> 
> ⚠️ Use it at your own risk! I'm not responsible for any damages or your wasted time trying to get your blog up and running on this. Also, I don't provide any support for this code, sorry.


## ⚙️ Tech details

**Blogging part:**
- Markdown with a bunch of [custom plugins](common/markdown/plugins)

**CI/CD:**
- Github Actions + SSH deployment using [docker-compose.production.yml](docker-compose.production.yml) as a service configuration


## 🏗️ How to build

If you like to build it from scratch:

```
$ pip3 install poetry
$ poetry install
$ poetry run manage.py migrate
$ poetry run manage.py runserver 8000
```

Don't forget to create an empty Postgres database called `vas3k_blog` or your migrations will fail.

Another option for those who prefer Docker:

```
$ docker-compose up
```

Then open http://localhost:8000 and see an empty page.

## Notes

Working with locales:

```bash
$(poetry env activate) # activate environment
python manage.py makemessage --all
# update locale/en/LC_MESSAGES/django.po at this stage with translations
python manage.py compilemessages
```