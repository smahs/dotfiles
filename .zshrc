# Lines configured by zsh-newuser-install
setopt autocd
unsetopt beep extendedglob nomatch
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/smahs/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Prompt customization
autoload -U colors && colors
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:git*' formats "%{${fg[blue]}%}[%{${fg[cyan]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[blue]}%}]%{$reset_color%} "

function virtual_env_prompt () {
    REPLY=${VIRTUAL_ENV+(${VIRTUAL_ENV:t}) }
}

function arrow_func () {
	REPLY="➡ "
}

grml_theme_add_token  virtual-env -f virtual_env_prompt '%F{magenta}' '%f'
grml_theme_add_token arrow -f arrow_func 
zstyle ':prompt:grml:left:setup' items virtual-env change-root path vcs arrow
zstyle ':prompt:grml:right:setup' items rc sad-smiley battery

setKeyboardLight () {
    dbus-send --system --type=method_call  --dest="org.freedesktop.UPower" "/org/freedesktop/UPower/KbdBacklight" "org.freedesktop.UPower.KbdBacklight.SetBrightness" int32:$1
}

export TERM=xterm-256color
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export GOPATH=~/workdir/go

alias rm='rm -fv'
alias vim='nvim'
alias latexmk='latex-mk'
alias ag='ag --ignore-dir={vendor,documentation,bower_components,venv,.venv,.env,public,templates} --ignore="*min.*js*"'
alias go-bindata='noglob go-bindata'
alias rgr='rg -T html -T js -T css -T md'

eval $(thefuck --alias)

export PATH=$PATH:$HOME/.google-cloud-sdk/bin
export PATH=$PATH:$HOME/.linkerd2/bin
