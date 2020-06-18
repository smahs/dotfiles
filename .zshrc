# Lines configured by zsh-newuser-install
setopt autocd
unsetopt beep extendedglob nomatch
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/smahs/.zshrc'

autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

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
zstyle ':prompt:grml:right:setup' items rc sad-smiley

# Enable direnv hook
eval "$(direnv hook zsh)"

setKeyboardLight () {
    dbus-send --system --type=method_call  --dest="org.freedesktop.UPower" "/org/freedesktop/UPower/KbdBacklight" "org.freedesktop.UPower.KbdBacklight.SetBrightness" int32:$1
}

# export TERM=xterm-256color
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# export LESS='--mouse'

# Go paths
export GOPATH=~/workdir/go
export PATH=$PATH:$GOPATH/bin

# Use pyenv to manage python runtime
eval "$(pyenv init -)"

# Local python bin path
export PATH=/home/smahs/.local/bin:$PATH

# Aliases
alias l='exa -lGF --git'
alias la='exa -la --git'
alias lt='exa -lTF -L 2 --git'
alias rm='rm -fv'
alias vim='nvim'
alias latexmk='latex-mk'
alias ag='ag --ignore-dir={vendor,documentation,bower_components,venv,.venv,.env,public,templates} --ignore="*min.*js*"'
alias go-bindata='noglob go-bindata'
alias rgr='rg -T html -T js -T css -T md'
alias open='xdg-open'

export PATH=$PATH:$HOME/.google-cloud-sdk/bin
export PATH=$PATH:$HOME/.linkerd2/bin

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/home/smahs/workdir/google-cloud-sdk/path.zsh.inc' ]; then . '/home/smahs/workdir/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '/home/smahs/workdir/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/smahs/workdir/google-cloud-sdk/completion.zsh.inc'; fi

# kubectl config follows:
#
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Helm completions
source <(helm completion zsh)

function ka_fun {
        kubectl $@ --all-namespaces
}

alias k=kubectl
alias kk='kubectl -n kube-system'
alias ka='ka_fun'

complete -F __start_kubectl k
complete -F __start_kubectl ka
complete -F __start_kubectl kk

# JWT Decoding
decode_base64_url() {
  local len=$((${#1} % 4))
  local result="$1"
  if [ $len -eq 2 ]; then result="$1"'=='
  elif [ $len -eq 3 ]; then result="$1"'=' 
  fi
  echo "$result" | tr '_-' '/+' | base64 --decode
}

decode_jwt() {
   decode_base64_url $(echo -n $2 | cut -d "." -f $1) | jq .
}

# Decode JWT header
alias jwth="decode_jwt 1"

# Decode JWT Payload
alias jwtp="decode_jwt 2"

db64() { echo $1 | base64 --decode; }
