######## GLOBAL VARS #########
LS_COLORS_FILE="${HOME}/dotfiles/config/dircolors.ansi-dark"
GIT_COMPLETE="${HOME}/dotfiles/config/git-completion.bash"
GIT_PROMPT="${HOME}/dotfiles/config/git-prompt.sh"

# enable colorized ls
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

if [ -e /etc/lsb-release ]; then
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias git-grep='git-grep --color=auto'
else
    # on Mac
    alias ls='ls -G'
fi

# on linux, set alias for open command
uname -a | grep -io linux>/dev/null && alias open='xdg-open'

alias ll='ls -l'

# Yelp-specific aliases
if [ -e ~/.yelp_bash_alias ]; then
    source ~/.yelp_bash_alias
fi

##-ANSI-COLOR-CODES-##
ColorOff='\[\033[0m\]'
###-Regular-###
Red='\[\033[0;31m\]'
Green='\[\033[0;32m\]'
Yellow='\[\033[0;33m\]'
Blue='\[\033[0;34m\]'
Purple='\[\033[0;35m\]'
Cyan='\[\033[0;36m\]'
### Light-###
LRed='\[\033[1;31m\]'
LGreen='\[\033[1;32m\]'
LBlue='\[\033[1;34m\]'
LPurple='\[\033[1;35m\]'
LCyan='\[\033[1;36m\]'
####-Bold-####
BRed='\[\033[1;31m\]'
BPurple='\[\033[1;35m\]'
BGreen='\[\033[1;32m\]'
BYellow='\[\033[1;33m\]'
BBlue='\[\033[1;34m\]'

# Enable git prompt
if [ -f "${GIT_COMPLETE}" ] && [ -f "${GIT_PROMPT}" ]; then
    source "${GIT_COMPLETE}"
    source "${GIT_PROMPT}"
    export PS1="${BBlue}\u@${ColorOff}${BGreen}\h${ColorOff} ${BYellow}\w${ColorOff} ${Cyan}"'$(__git_ps1 "(%s)")'"${ColorOff}\n${BPurple}\$${ColorOff} "
else
    export PS1="${BBlue}\u@${ColorOff}${BGreen}\h${ColorOff} ${BYellow}\w${ColorOff} ${BPurple}\n\$${ColorOff} "
fi

function path_contains {
    echo "$PATH" | grep -q "$1"
}

function prepend_to_path {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        echo "[WARNING] $dir does not exist">&2
        local x=1
    else
        if ! path_contains "$dir"; then
            export PATH="$dir:$PATH"
        else
            #echo "[WARNING] $dir already on path..."
            local x=1
        fi
    fi
}

function configure_git {
    git config --global core.ui true
    git config --global core.editor vim
}

function append_to_path {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        echo "[WARNING] $dir does not exist">&2
    else
        if ! path_contains "$dir"; then
            export PATH="$PATH:$dir"
        fi
    fi
}

function append_to_path_if_exists {
    local dir="$1"
    if [ -d "$dir" ]; then
        append_to_path "$dir"
    fi
}

realpath() {
	[[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

type -a realpath >/dev/null || export realpath

# make sure to read /usr/local/bin before anything else in PATH (for Homebrew on Mac)
prepend_to_path "/usr/local/bin"

# set the terminal to be 256-color compatible
export TERM="screen-256color"

configure_git

if [ -f ~/.git-completion.sh ]; then
    source ~/.git-completion.sh
fi

### Added by the Heroku Toolbelt
append_to_path_if_exists "/usr/local/heroku/bin"

# Add RVM to PATH for scripting
append_to_path_if_exists "$HOME/.rvm/bin"

# add Spark to PATH
append_to_path_if_exists "/opt/spark-2.0.1-bin-hadoop2.6/bin"

# javascript stuff
append_to_path_if_exists "$HOME/node_modules/jshint/bin"

# postgres on Mac
append_to_path_if_exists "/Applications/Postgres.app/Contents//Versions/9.3/bin"
