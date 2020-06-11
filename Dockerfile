FROM archlinux/base

LABEL maintainer="jk@vin.ovh"

RUN pacman -Syu --needed --noconfirm sudo namcap fakeroot audit grep diffutils

RUN pacman -S --noconfirm base-devel distcc git

RUN useradd --create-home build
RUN echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# install chromium dependencies
SHELL ["/bin/bash", "-c", "source <(curl -SL https://raw.githubusercontent.com/felixonmars/archlinux-packages/master/chromium/repos/extra-x86_64/PKGBUILD)"]
RUN pacman -Syu --noconfirm --needed --asdeps "${makedepends[@]}" "${depends[@]}"

USER build
WORKDIR /home/build

# install yay which can be used to install AUR dependencies
RUN git clone https://aur.archlinux.org/yay.git
RUN cd yay && makepkg --syncdeps --install --noconfirm
