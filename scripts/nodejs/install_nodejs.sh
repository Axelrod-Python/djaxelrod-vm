apt-get -y install nodejs npm nodejs-legacy
npm install
npm install -g bower
npm install -g gulp

# configure Gulp as an upstart daemon
cp /tmp/gulp-server.conf /etc/init
