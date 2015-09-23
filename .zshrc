#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd extendedglob
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/smahs/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

setopt nohashdirs
autoload -Uz promptinit
promptinit

zstyle ':completion:*' rehash true
# source /usr/share/zsh/site-contrib/powerline.zsh

export TERM=xterm-256color

export GOPATH=~/workspace/go
export PATH=$PATH:/home/smahs/.gem/ruby/2.2.0/bin:$GOPATH/bin
#export VDPAU_DRIVER=nouveau
#export DRI_PRIME=1
export CHROMIUM_USER_FLAGS=--disable-web-security

stty -ixon

alias bmux='BYOBU_WINDOWS=split3 byobu'
alias rm='rm -fv'
alias terminator='terminator -l sm'

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
