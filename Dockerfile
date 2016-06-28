
FROM debian:jessie
MAINTAINER Matt Finkel <finkel.matt@gmail.com>
VOLUME [ "/src", "/workspace" ]
WORKDIR /workspace

ARG uid
ARG gid

RUN apt-get update -y && \
		apt-get install -y \
		vim \
		zsh \
		git \
		python \
		exuberant-ctags

RUN mkdir -p /home/mfinkel
RUN groupadd -r -g $gid mfinkel
RUN useradd -r -u $uid -d /home/mfinkel -g mfinkel mfinkel
RUN chown mfinkel:mfinkel /home/mfinkel

USER mfinkel

RUN mkdir /home/mfinkel/config
RUN git clone https://github.com/fffinkel/dotfiles.git /home/mfinkel/config/dotfiles
RUN git clone https://github.com/fffinkel/vim.git /home/mfinkel/config/vim
RUN git clone https://github.com/fffinkel/zsh.git /home/mfinkel/config/zsh

RUN cd /home/mfinkel/config/zsh && git submodule init
RUN cd /home/mfinkel/config/zsh &&  git submodule update

RUN ln -s /home/mfinkel/config/vim/vim /home/mfinkel/.vim
RUN ln -s /home/mfinkel/config/vim/vimrc /home/mfinkel/.vimrc
RUN ln -s /home/mfinkel/config/zsh/zsh /home/mfinkel/.zsh
RUN ln -s /home/mfinkel/config/zsh/zshrc /home/mfinkel/.zshrc

RUN git clone https://github.com/VundleVim/Vundle.vim.git /home/mfinkel/.vim/bundle/Vundle.vim

RUN vim +PluginInstall +qall

ENTRYPOINT zsh
