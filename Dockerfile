
FROM debian:jessie
MAINTAINER Matthew Finkel <mfinkel@shoretel.com>
VOLUME [ "/src", "/workspace" ]

RUN apt-get update -y && \
		apt-get install -y \
		vim \
		zsh \
		screen \
		git \
		python \
		exuberant-ctags

RUN mkdir /config

WORKDIR /workspace
RUN mkdir /config/versioned

RUN mkdir /config/blah

RUN groupadd -r mfinkel && useradd -r -d /workspace -g mfinkel mfinkel

RUN chsh -s /bin/zsh

RUN git clone https://github.com/fffinkel/dotfiles.git /config/dotfiles
RUN git clone https://github.com/fffinkel/vim.git /config/vim
RUN git clone https://github.com/fffinkel/zsh.git /config/zsh

WORKDIR /config/zsh
RUN git submodule init
RUN git submodule update
WORKDIR /workspace

RUN ln -s /config/vim/vim ~/.vim
RUN ln -s /config/vim/vimrc ~/.vimrc
RUN ln -s /config/zsh/zsh ~/.zsh
RUN ln -s /config/zsh/zshrc ~/.zshrc
RUN ln -s /config/dotfiles/screenrc ~/.screenrc

RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

RUN mkdir ~/.vim/swap

RUN vim +PluginInstall +qall

#USER mfinkel

ENTRYPOINT zsh
