FROM ubuntu:16.04
MAINTAINER Emmanuel Lepage-Vallee (elv1313@gmail.com)

RUN apt update

RUN apt install git dpkg-dev devscripts equivs -yy

RUN git clone https://github.com/savoirfairelinux/ring-daemon.git

WORKDIR ring-daemon

ADD debian /ring-daemon/debian

# Install all dependencies
RUN mk-build-deps \
     -t 'apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -qqy' \
     -i -r debian/control

CMD git fetch origin && git reset --hard origin/master && \
 mkdir -p contrib/native && cd contrib/native && ../bootstrap &&\
 make fetch-all && cd ../.. &&\
 sed 's/ opus / /' -i contrib/src/ffmpeg/rules.mak &&\
 tar -cj . -f ../../ring-daemon_4.0.0.orig.tar.bz2 && \
 dpkg-buildpackage -jauto  &&\
 cp /*.deb /exportdebs/ -v && cp /*.tar.bz2 /exportdebs/
