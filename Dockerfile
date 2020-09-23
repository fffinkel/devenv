
FROM debian:jessie
MAINTAINER Matt Finkel <finkel.matt@gmail.com>
VOLUME [ "/src", "/workspace" ]
WORKDIR /workspace

ARG uid
ARG gid
ARG usr

RUN apt-get update -y && \
		apt-get install -y \
		vim \
		zsh \
		git \
		python \
		exuberant-ctags

RUN mkdir -p /home/$usr
RUN groupadd -r -g $gid $usr
RUN useradd -r -u $uid -d /home/$usr -g $usr $usr
RUN chown $usr:$usr /home/$usr

USER $usr

RUN mkdir /home/$usr/config
RUN git clone https://github.com/fffinkel/dotfiles.git /home/$usr/config/dotfiles
RUN git clone https://github.com/fffinkel/vim.git /home/$usr/config/vim
RUN git clone https://github.com/fffinkel/zsh.git /home/$usr/config/zsh

RUN cd /home/$usr/config/zsh && make install
RUN cd /home/$usr/config/vim && make install
RUN cd /home/$usr/config/dotfiles && make install

ENTRYPOINT zsh
