FROM ubuntu:zesty
MAINTAINER info@analogic.cz

ENV DEBIAN_FRONTEND noninteractive
ENV TERM=xterm

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y dirmngr

RUN echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu zesty main" >> /etc/apt/sources.list && \
    echo "deb-src http://ppa.launchpad.net/ondrej/php/ubuntu zesty main"  >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E5267A6C

RUN apt-get update

########### base ###########
RUN apt-get -y --no-install-recommends install locales busybox-syslogd wget nano

########### qpsmtpd ###########
RUN apt-get -y --no-install-recommends install libnet-dns-perl libmailtools-perl libmail-dkim-perl libmail-spf-perl libgeo-ip-perl libclamav-client-perl libipc-shareable-perl libdbi-perl libdbd-sqlite3-perl libarchive-zip-perl libmime-tools-perl

########### qpsmtpd-dmarc ###########
RUN apt-get -y --no-install-recommends install libcgi-pm-perl libxml-libxml-perl

########### qmail compile and stuff ###########
RUN apt-get -y --no-install-recommends install gcc make patch groff-base build-essential libssl-dev libperl-dev

########### dovecot ###########
RUN apt-get -y --no-install-recommends install dovecot-core dovecot-imapd dovecot-pop3d dovecot-sqlite dovecot-sieve dovecot-managesieved

########### clamav ###########
RUN apt-get -y --no-install-recommends install clamav-daemon

########### spamassassin ###########
RUN apt-get -y --no-install-recommends install spamassassin pyzor

########### sqlite ###########
RUN apt-get -y --no-install-recommends install sqlite3

########### roundcube ###########
RUN apt-get -y --no-install-recommends install nginx-light php7.1-fpm php7.1-mcrypt php7.1-intl php7.1-sqlite php7.1-cli php7.1-xmlrpc php7.1-curl php7.1-mbstring php7.1-zip php7.1-dom

########### zpush ###########
RUN apt-get -y --no-install-recommends install php-soap php7.1-imap

########### admin ###########
RUN apt-get -y --no-install-recommends install dnsutils mpack unzip sudo psmisc