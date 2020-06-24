FROM archlinux/base

LABEL maintainer="jk@vin.ovh"

RUN pacman -Syu --needed --noconfirm sudo namcap fakeroot audit grep diffutils

RUN pacman -S --noconfirm base-devel git chromium python-selenium

RUN useradd --create-home build
RUN echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# install chromium dependencies
SHELL ["/bin/bash", "-c"]
RUN source <(curl -SL https://raw.githubusercontent.com/felixonmars/archlinux-packages/master/chromium/repos/extra-x86_64/PKGBUILD) \
        && pacman -Syu --noconfirm --needed --asdeps "${makedepends[@]}" "${depends[@]}"
