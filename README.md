
sudo docker build . -t elv13/ring-daemon
sudo docker run -v $PWD/cache:/ring-daemon/contrib/tarballs/ -ti elv13/ring-daemon
