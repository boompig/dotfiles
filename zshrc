autoload -U compinit promptinit colors
compinit
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

psql_app_path='/Applications/Postgres.app'
if [ -d "$psql_app_path" ]; then
    psql_bin_path="$psql_app_path/Contents/Versions/latest/bin"
    PATH="$PATH:$psql_bin_path"
fi

ZSH_COLOR_PLUGIN="$HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
if [ -f "$ZSH_COLOR_PLUGIN" ]; then
    source "$ZSH_COLOR_PLUGIN"
fi

### Added by the Heroku Toolbelt
if [ -d "/usr/local/heroku/bin" ]; then
    export PATH="/usr/local/heroku/bin:$PATH"
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

MAC_CMAKE_PATH="/Applications/CMake.app/Contents/bin"
if [ -d "$MAC_CMAKE_PATH" ]
then
    export PATH="$PATH:$MAC_CMAKE_PATH"
fi

#############################################################################

# set emacs mode
set -o emacs
alias py='python'

export TERM='xterm-256color'

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

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

bindkey -e
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey "^[[3~" delete-char

stockfish_path="/usr/local/stockfish/bin"
if [ -d "$stockfish_path" ] && ! command_exists stockfish; then
    export PATH="$PATH:$stockfish_path"
fi

if command_exists yarn; then
    export PATH="$PATH:$(yarn global bin)"
fi

export PATH="$PATH:$HOME/Library/Python/2.7/bin"

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
export PATH="$HOME/.cargo/bin:$PATH"
