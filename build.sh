#!/bin/bash
set -euo pipefail # Exit with nonzero exit code if anything fails
set -x # debug

apt update
apt install -y --no-install-recommends autoconf automake build-essential gettext gcc libtool make \
libglib2.0-dev libhttp-parser-dev libotr5-dev libgnutls28-dev \
libjson-glib-dev libpng-dev libolm-dev libprotobuf-c-dev protobuf-c-compiler \
libgcrypt20-dev libmarkdown2-dev libpurple-dev libsqlite3-dev libwebp-dev libtool-bin \
software-properties-common

cd
curl -LO# https://get.bitlbee.org/src/bitlbee-$BITLBEE_VERSION.tar.gz &
#curl -LO# https://github.com/EionRobb/skype4pidgin/archive/1.7.tar.gz &
curl -LO# https://github.com/bitlbee/bitlbee-facebook/archive/v1.2.2.tar.gz &
#git clone https://github.com/EionRobb/purple-hangouts.git &
#git clone https://alexschroeder.ch/cgit/bitlbee-mastodon &
#git clone https://github.com/EionRobb/purple-rocketchat.git &
#curl -LO# https://github.com/sm00th/bitlbee-discord/archive/0.4.3.tar.gz &
#git clone https://github.com/dylex/slack-libpurple.git &
#git clone https://github.com/jgeboski/bitlbee-steam.git &
#git clone https://github.com/matrix-org/purple-matrix.git &
#git clone https://github.com/EionRobb/purple-mattermost.git &
#git clone https://github.com/EionRobb/purple-instagram.git &
git clone https://github.com/EionRobb/purple-teams &
#git clone --recurse-submodules https://github.com/hoehermann/purple-signald.git purple-signald &

wait

# # bitlbee
tar zxvf bitlbee-$BITLBEE_VERSION.tar.gz
cd bitlbee-$BITLBEE_VERSION
./configure --jabber=1 --otr=1 --purple=1
make
make install
make install-dev

# ms teams
#cd
#cd purple-teams
#make
#make install

## signal
#cd
#mkdir -p purple-signald/build
#cd purple-signald/build
#cmake ..
#make
#make install

# skypeweb
#cd
#tar zxvf 1.7.tar.gz
#cd skype4pidgin-1.7/skypeweb
#make
#make install

# tdlib-purple
#curl -fsSL https://download.opensuse.org/repositories/home:ars3n1y/Debian_11/Release.key | apt-key add -
#apt-add-repository 'deb http://download.opensuse.org/repositories/home:/ars3n1y/Debian_11/ /'
#apt update
#apt install -y --no-install-recommends libpurple-telegram-tdlib

# bitlbee-facebook
cd
tar zxvf v1.2.2.tar.gz
cd bitlbee-facebook-1.2.2
./autogen.sh
make
make install

# purple-hangouts
#cd
#cd purple-hangouts
#make
#make install

# bitlbee-mastodon
#cd
#cd bitlbee-mastodon
#sh autogen.sh
#./configure
#make
#make install

# purple-rocketchat
#cd
#cd purple-rocketchat
#make
#make install

# bitlbee-discord
#cd
#tar zxvf 0.4.3.tar.gz
#cd bitlbee-discord-0.4.3/
#./autogen.sh
#./configure
#make
#make install

## slack-libpurple
#cd
#cd slack-libpurple
#make install

# bitlbee-steam
#cd
#cd bitlbee-steam
#./autogen.sh
#make
#make install

# purple-matrix
#cd
#cd purple-matrix
#make
#make install

# purple-mattermost
#cd
#cd purple-mattermost
#make
#make install

# purple-instagram
#cd
#cd purple-instagram
#make
#make install

# libtool --finish
libtool --finish /usr/local/lib/bitlbee

# cleanup
apt autoremove --purge -y
apt remove -y --purge autoconf automake autotools-dev binutils binutils-common binutils-x86-64-linux-gnu build-essential \
bzip2 cpp* dpkg-dev gettext gettext-base libbinutils libgcc-*-dev libsqlite3-dev libstdc++-*-dev \
libtasn1-*-dev libtool libtool-bin m4 make nettle-dev patch xz-utils cmake
apt clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /tmp/*
cd
rm -fr /root/build.sh || true
rm -fr $BITLBEE_VERSION* || true
rm -fr 1.7.tar.gz skype4pidgin-* || true
rm -fr v1.2.1.tar.gz bitlbee-facebook-* || true
rm -fr purple-hangouts || true
rm -rf bitlbee-mastodon || true
rm -rf purple-rocketchat || true
rm -fr bitlbee-discord-0.4.3/ 0.4.3.tar.gz || true
rm -fr slack-libpurple || true
rm -fr bitlbee-steam || true
rm -fr purple-matrix || true
rm -fr purple-mattermost || true
rm -fr purple-instagram || true

# add user bitlbee
adduser --system --home /var/lib/bitlbee --disabled-password --disabled-login --shell /usr/sbin/nologin bitlbee
touch /var/run/bitlbee.pid && chown bitlbee:nogroup /var/run/bitlbee.pid
