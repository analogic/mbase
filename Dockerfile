FROM ubuntu:zesty
MAINTAINER info@analogic.cz

ENV DEBIAN_FRONTEND noninteractive
ENV TERM=xterm

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y dirmngr && \

    echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu zesty main" >> /etc/apt/sources.list && \
    echo "deb-src http://ppa.launchpad.net/ondrej/php/ubuntu zesty main"  >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E5267A6C && \

    apt-get update && \

    ########### base ###########
    apt-get -y --no-install-recommends install locales busybox-syslogd nano \

    ########### qpsmtpd ###########
    libnet-dns-perl libmailtools-perl libmail-dkim-perl libmail-spf-perl libgeo-ip-perl libclamav-client-perl libipc-shareable-perl libdbi-perl libdbd-sqlite3-perl libarchive-zip-perl libmime-tools-perl \

    ########### qpsmtpd-dmarc ###########
    libcgi-pm-perl libxml-libxml-perl \

    ########### dovecot ###########
    dovecot-core dovecot-imapd dovecot-pop3d dovecot-sqlite dovecot-sieve dovecot-managesieved \

    ########### clamav ###########
    clamav-daemon \

    ########### spamassassin ###########
    spamassassin pyzor \

    ########### sqlite ###########
    sqlite3 \

    ########### roundcube ###########
    nginx-light php7.1-fpm php7.1-mcrypt php7.1-intl php7.1-sqlite php7.1-cli php7.1-xmlrpc php7.1-curl php7.1-mbstring php7.1-zip php7.1-dom \

    ########### zpush ###########
    php-soap php7.1-imap \

    ########### admin ###########
    dnsutils mpack unzip sudo psmisc && \

    # clean to reduce image size
    apt-get remove -y --purge --auto-remove  --allow-remove-essential \
        dirmngr \
        bind9-host \
        e2fslibs \
        e2fsprogs && \
    find /usr/share/doc -depth -type f ! -name copyright | xargs rm || true && \
    find /usr/share/doc -empty | xargs rmdir || true && \
    rm -rf /usr/share/man/* /usr/share/groff/* /usr/share/info/* && \
    rm -rf /usr/share/lintian/* /usr/share/linda/* /var/cache/man/* && \
    rm -rf /installation && \
    rm -rf /var/lib/apt/lists/* && \
    rm /etc/cron.weekly/fstrim && \
    rm -Rf /packages && \
    rm -Rf /tmp/*
