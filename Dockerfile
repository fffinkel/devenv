
FROM debian:jessie
MAINTAINER Matthew Finkel <mfinkel@shoretel.com>
VOLUME /src

RUN apt-get update -y && \
		apt-get install -y \
		vim \
		zsh \
		screen \
		git \
		exuberant-ctags

RUN mkdir /config

RUN git clone http://git.mfinkel.net/configs/vim.git /config/vim/
RUN git clone http://git.mfinkel.net/configs/zsh.git /config/zsh/
RUN git clone http://git.mfinkel.net/configs/dotfiles.git /config/dotfiles/

RUN git clone https://github.com/VundleVim/Vundle.vim.git /config/vim/vim/bundle/Vundle.vim

RUN ln -s /config/vim/vim ~/.vim
RUN ln -s /config/vim/vimrc ~/.vimrc
RUN ln -s /config/zsh/zsh ~/.zsh
RUN ln -s /config/zsh/zshrc ~/.zshrc
RUN ln -s /config/dotfiles/screenrc ~/.screenrc

RUN mkdir ~/.vim/swap

RUN vim +PluginInstall +qall
