update_upgrade () {
  sudo apt-get update && sudo apt-get upgrade --assume-yes
}

install () {
  sudo apt-get --assume-yes install \
    emacs \
    bochs \
    qemu \
    build-essential \
    htop \
    clang \
    aptitude \
    git git-el \
    subversion \
    byacc bison \
    flex \
    autoconf \
    libtool \
    openjdk-7-jdk
# autoconf: protobuf, googlemock
# libtool: protobuf
}

install_chrome () {
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
  sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb
}

git_config() {
  git config --global user.name "Andre Nogueira"
  git config --global user.email "andre.nogueira@gmail.com"
}

install_libs() {
  install_lib_protobuf
  install_lib_glog
  install_lib_googlemock
}

install_lib_protobuf() {
  mkdir -p ~/src
  pushd ~/src
  svn checkout http://protobuf.googlecode.com/svn/trunk/ protobuf
  pushd protobuf
  ./autogen.sh
  ./configure
  make -j 5
  make check -j 5
  sudo make install
  popd
  popd
}

install_lib_glog() {
  mkdir -p ~/src
  pushd ~/src
  svn checkout http://google-glog.googlecode.com/svn/trunk/ google-glog
  pushd google-glog
  ./configure
  make -j 5
  sudo make install
  popd
  popd
}

install_lib_googlemock() {
  mkdir -p ~/src
  pushd ~/src
  svn checkout http://googlemock.googlecode.com/svn/trunk/ googlemock
  pushd googlemock
  autoreconf -fvi
  ./configure
  make -j 5
  make check -j 5
  #sudo make install
  popd
  popd
}

all () {
  update_upgrade
  git_config
  install
  install_chrome
  install_libs
}

set -x
${1}
set +x
