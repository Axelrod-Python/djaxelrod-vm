locale="en_GB.UTF-8"
timezone="Europe/London"

/usr/sbin/locale-gen $locale
/usr/sbin/update-locale LANG=$locale LC_ALL=$locale LANGUAGE=$locale
echo $timezone > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

apt-get update
apt-get -y upgrade
apt-get -y install linux-headers-$(uname -r) git curl pkg-config libfreetype6-dev libpng12-dev redis-server

sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=sudo' /etc/sudoers
sed -i -e 's/%sudo  ALL=(ALL:ALL) ALL/%sudo  ALL=NOPASSWD:ALL/g' /etc/sudoers

echo "UseDNS no" >> /etc/ssh/sshd_config
