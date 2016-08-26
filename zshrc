autoload -U compinit promptinit colors
compinit
colors

# enable prompt substitution for git branch in prompt
setopt prompt_subst
autoload -Uz vcs_info
promptinit

# no history duplicates
setopt HIST_IGNORE_DUPS

HISTFILE="$HOME/.zhistory"
HISTSIZE=1000
SAVEHIST=1000

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

if [ $USER = "root" ]
then
    PROMPT="%{$fg_bold[red]%}%n@%{$fg_bold[green]%}%m %{$fg_bold[yellow]%}%~$git_prompt%{$fg_bold[magenta]%}$ %{$reset_color%}"
else
    PROMPT="%{$fg_bold[blue]%}%n@%{$fg_bold[green]%}%m %{$fg_bold[yellow]%}%~$git_prompt%{$fg_bold[magenta]%}
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
uname -a | grep -o Linux>/dev/null
if [ $? -eq 0 ]
then
    alias ls='ls --color=auto'
else
    alias ls='ls -G'
fi
alias ll='ls -l'
alias grep='grep --color=auto'

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

local psql_app_path='/Applications/Postgres.app'
if [ -d "$psql_app_path" ]; then
    local psql_bin_path=$(find "$psql_app_path/Contents/Versions" -name 'bin')
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

is_mac=$(uname -a | grep -o Darwin >/dev/null && echo 1 || echo 0)

# Mac only: homebrew settings
if [ $is_mac ] && [ -d "/usr/local/bin" ]; then
	# make sure we are using homebrew version of executables
    export PATH="/usr/local/bin:$PATH"
	export HOMEBREW_NO_ANALYTICS=1
fi

if [ -e "$HOME/.printer-prefs" ]; then
    source "$HOME/.printer-prefs"
fi

# on Macs, make sure gcc is homebrew version
uname -a | grep -o Linux>/dev/null
if [ $? -ne 0 ]; then
    if [ -e "/usr/local/bin/gcc-4.9" ]; then
        alias gcc='/usr/local/bin/gcc-4.9'
    fi
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

# git config
function git_config {
    git config --global user.name "Daniel Kats"
    git config --global user.email "dbkats@cs.toronto.edu"
	git config --global core.editor $(which vim)
}

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

bindkey -e
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey "^[[3~" delete-char

# set vim as the editor
export VISUAL=$(which vim)
export EDITOR=$(which vim)
