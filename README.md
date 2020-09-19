# environment
- Python 3.7.7
- Django 2.1.7
- Postgresql 12.2

# extra packages
- Impersonate
- Precise BBCode

# installation
- run db/exile_nexus.sql on db server
- run db/exile_static.sql on db server
- run db/exile_s03.sql on db server
- create a new galaxy with SQL command "SELECT admin_create_galaxies(1, 1);"
- configure your server/settings.py with your environment
- create a server/confidential.py file with your confidential info
- create a Django superuser
- run your Django server


Enjoy !
