autoload -Uz compinit promptinit colors

# TODO for startup time profiling
#zmodload zsh/zprof

# display colors when autocompleting commands
export LSCOLORS=ExFxCxDxBxegedabagacad
export LS_COLORS=ExFxCxDxBxegedabagacad
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

# note that compinit is pretty slow so best to only do it once per day
for dump in ~/.zcompdump(N.mh+24); do
	compinit
done
compinit -C

colors

# enable prompt substitution for git branch in prompt
setopt prompt_subst
autoload -Uz vcs_info
promptinit

# no history duplicates
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
# save commands to history as soon as they are entered
setopt INC_APPEND_HISTORY

HISTFILE="$HOME/.zhistory"
# max number of lines kept in a "session"
HISTSIZE=10000
# max number of lines kept in a file
SAVEHIST=10000

# git in prompt
zstyle ':vcs_info:*' actionformats \
        '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
        '%F{6}(%b)%f '
        # this bottom one is displayed for some reason, dunno about the top
        # the %F{6} is for cyan

zstyle ':vcs_info:*' enable git

vcs_info_wrapper() {
    vcs_info
    if [ -n "$vcs_info_msg_0_" ]; then
        echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
    fi
}
RPROMPT=$'$(vcs_info_wrapper)'
if [ -z $RPROMPT ]; then
    git_prompt=""
else
    git_prompt=" $RPROMPT"
fi

if [ "$USER" = "root" ]; then
    PROMPT="%{$fg[red]%}%n@%{$fg[green]%}%m %{$fg[yellow]%}%~$git_prompt%{$fg[magenta]%}$ %{$reset_color%}"
else
    PROMPT="%{$fg[blue]%}%n@%{$fg[green]%}%m %{$fg[yellow]%}%~$git_prompt%{$fg[magenta]%}
$ %{$reset_color%}"
fi

# do right-prompt
RPROMPT=""
zle-keymap-select () {
    case $KEYMAP in
        vicmd)
            RPROMPT="%{$fg_bold[red]%}"'[c]'"%{$reset_color%}"
            ;; # block cursor
        viins|main)
            #RPROMPT="%{$fg_bold[green]%}"'[i]'"%{$reset_color%}"
            RPROMPT=''
            ;;
        *)
            RPROMPT=''
            ;;
    esac
    zle reset-prompt
}
zle -N zle-keymap-select

################################## aliases and PATH ##################################
is_linux=$(uname -a | grep -q 'Linux' && echo 1 || echo 0)
if [ "$is_linux" -eq 1 ]; then
    alias ls='ls --color=auto'
else
    alias ls='ls -G'
fi
alias ll='ls -l'
alias grep='grep --color=auto'
#alias vim="$(which nvim)"
alias ipy='ipython'

vims () {
    local session_dir="${HOME}/.vim/sessions/$1.vim"
    if [ -f "${session_dir}" ]
    then
        vim -S "${session_dir}"
    else
        echo "No such session: ${session_dir}">&2
    fi
}
export vims

SYMANTEC_ALIAS_PATH="$HOME/.symantec_bash_alias"
if [ -f "$SYMANTEC_ALIAS_PATH" ]; then
    source "$SYMANTEC_ALIAS_PATH"
fi

UT_ALIAS_PATH="$HOME/.ut_bash_alias"
if [ -f "$UT_ALIAS_PATH" ]; then
    source "$UT_ALIAS_PATH"
fi

MAC_ALIAS_PATH="$HOME/.mac_alias"
if [ -f "$MAC_ALIAS_PATH" ]; then
    source "$MAC_ALIAS_PATH"
fi
alias ssh-pi='ssh pi@raspberrypi'

LINUX_ALIAS_PATH="$HOME/.linux_bash_alias"
if [ -f "$LINUX_ALIAS_PATH" ]; then
    source "$LINUX_ALIAS_PATH"
fi

SUBLIME_PATH="/opt/sublime_text/sublime_text"
if [ -x "$SUBLIME_PATH" ]; then
    alias sublime="$SUBLIME_PATH"
fi

ZSH_COLOR_PLUGIN="$HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
if [ -f "$ZSH_COLOR_PLUGIN" ]; then
    source "$ZSH_COLOR_PLUGIN"
fi

is_mac=$(uname -a | grep -q Darwin && echo 1 || echo 0)

# Mac only: homebrew settings
if [ "$is_mac" -eq 1 ] && [ -d "/usr/local/bin" ]; then
	# make sure we are using homebrew version of executables
    export PATH="/usr/local/bin:$PATH"
	export HOMEBREW_NO_ANALYTICS=1
fi

if [ -e "$HOME/.printer-prefs" ]; then
    source "$HOME/.printer-prefs"
fi

# on Macs, make sure gcc is homebrew version
if [ "$is_mac" -eq 1 ] && [ -e "/usr/local/bin/gcc-4.9" ]; then
    alias gcc='/usr/local/bin/gcc-4.9'
fi


#############################################################################

# set emacs mode
set -o emacs
alias py='python'

export TERM='screen-256color'

#if [[ "$TERM" != screen* ]]
#then
    #exec tmux
#fi

function command_exists {
    hash "$1" 2>/dev/null
}
VIM_PATH="$(which vim)"

# git config
function git_config {
    git config --global user.name "Daniel Kats"
    git config --global user.email "dbkats@cs.toronto.edu"
	git config --global core.editor "$VIM_PATH"
}

if [ -d "$HOME/.rvm" ]; then
fi

bindkey -e
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey "^[[3~" delete-char

function append_to_path_if_exists {
	if [ -d "$1" ]; then
		export PATH="$PATH:$1"
	fi
}

if command_exists yarn; then
	append_to_path_if_exists "$(yarn global bin)"
fi

append_to_path_if_exists "$HOME/Library/Python2.7/bin"
append_to_path_if_exists "/usr/local/stockfish/bin"
append_to_path_if_exists "$HOME/.rvm/bin"
append_to_path_if_exists "/Applications/CMake.app/Contents/bin"
append_to_path_if_exists "/usr/local/heroku/bin"
append_to_path_if_exists "/Applications/Postgres.app/Contents/Versions/latest/bin"

# set vim as the editor
export VISUAL="$VIM_PATH"
export EDITOR="$VIM_PATH"
alias crontab="VIM_CRONTAB=true crontab"


which go >/dev/null 2>/dev/null
if [ $? -eq 0 ]; then
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOPATH/bin
fi

which terraform >/dev/null 2>/dev/null
if [ $? -eq 0 ]; then
    alias tf=terraform
fi

# add rust
append_to_path_if_exists "$HOME/.cargo/bin"

# add java home
JAVA_HOME_DIR='/usr/libexec/java_home'
if [ -f "$JAVA_HOME_DIR" ]; then
	export JAVA_HOME="$($JAVA_HOME_DIR -v 1.8 2>/dev/null)"
	if [ $? -eq 0 ]; then
		export PATH=${JAVA_HOME}/bin:$PATH
	fi
fi

# add nvm
if [ -f "$HOME/.nvm" ]; then
	export NVM_DIR="$HOME/.nvm"
fi

# ----- do not load NVM because it is slow as hell
# This loads nvm
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
# This loads nvm bash_completion
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

# TODO for startup time profiling
#zprof
