# Written by Daniel Kats
# May 27, 2014

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

if [ -e /Applications/Postgres.App ]; then
    alias psql='/Applications/Postgres.app/Contents//Versions/9.3/bin/psql'
fi

# Yelp-specific aliases
if [ -e ~/.yelp_bash_alias ]; then
	source ~/.yelp_bash_alias
fi

# javascript stuff
if [ -d ~/node_modules ] && [ -d ~/node_modules/jshint ]; then
    PATH="$HOME/node_modules/jshint/bin:$PATH"
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

# Enable git prompt
if [ -f ${GIT_COMPLETE} ] && [ -f ${GIT_PROMPT} ]; then
	source ${GIT_COMPLETE}
	source ${GIT_PROMPT}
	export PS1="${BPurple}\h${ColorOff} ${BGreen}[ \w ]${ColorOff} ${Cyan}"'$(__git_ps1 "(%s)")'"${ColorOff} ${Yellow}\$${ColorOff} "
else
	export PS1="${BPurple}\h${ColorOff} ${BGreen}[ \w ]${ColorOff} ${Yellow}\$${ColorOff} "
fi

PATH="/usr/local/bin:${PATH}"

# set the terminal to be 256-color compatible
export TERM="xterm-256color"

### Added for the Heroku Toolbelt
if [ -d /usr/local/heroku ]; then
    export PATH="/usr/local/heroku/bin:$PATH"
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# set vim as default editor
git config --global core.ui true
git config --global core.editor vim
