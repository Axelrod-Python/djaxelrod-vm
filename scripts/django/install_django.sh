DJANGO_PROJECT="djaxelrod"

# install packages
apt-get install -y python-setuptools libpq-dev python-dev g++ redis-server
easy_install pip

# install python packages
curl https://raw.githubusercontent.com/Axelrod-Python/DjAxelrod/master/requirements.txt > /tmp/requirements.txt
pip install -r /tmp/requirements.txt
pip install django-debug-toolbar

# Set environment variables
if ! grep -Fq "DEBUG" /etc/environment
then
    sudo echo "DEBUG=TRUE" >> /etc/environment
    sudo echo "SOCIAL_AUTH_GOOGLE_OAUTH2_KEY='237400346062-fgmcf2r36vgqfh0nuisd8ofi8ot5nrp4.apps.googleusercontent.com'" >> /etc/environment
    sudo echo "SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET='sKyWX8OQnuIWusn3WTFEevQt'" >> /etc/environment
    sudo echo "SECRET_KEY='LousyKeyOnlySuitableForDevEnvironments'" >> /etc/environment
    sudo echo "DATABASE_URL='postgres://$DJANGO_PROJECT:$DJANGO_PROJECT@localhost/$DJANGO_PROJECT'" >> /etc/environment
fi

# Create database
user_exists=`sudo -u postgres psql -tAc "SELECT 1 FROM pg_roles WHERE rolname='$DJANGO_PROJECT'"`
db_exists=`sudo -u postgres psql -tAc "SELECT 1 FROM pg_database WHERE datname='$DJANGO_PROJECT'"`
su postgres -c "createuser -w -d -r -s $DJANGO_PROJECT"
sudo -u postgres psql -c "ALTER USER $DJANGO_PROJECT WITH PASSWORD '$DJANGO_PROJECT';"
su postgres -c "createdb -O $DJANGO_PROJECT $DJANGO_PROJECT"

# configure the django dev server as an upstart daemon
cp /tmp/django-server.conf /etc/init

# configure celery as an upstart daemon
cp /tmp/celery-server.conf /etc/init
