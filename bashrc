######## GLOBAL VARS #########
LS_COLORS_FILE="${HOME}/dotfiles/config/dircolors.ansi-dark"
GIT_COMPLETE="${HOME}/dotfiles/config/git-completion.bash"
GIT_PROMPT="${HOME}/dotfiles/config/git-prompt.sh"

# enable colorized ls
if [ -e /etc/lsb-release ]; then
	alias ls='ls --color=auto'
  alias grep='grep --color=auto'
else
	# on Mac
	alias ls='ls -G'
fi

# get LS colors from config directory if possible
if [ -e ${LS_COLORS_FILE} ] && [ $(which dircolors) ]; then
	eval "$(dircolors ${LS_COLORS_FILE})"
fi

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

# Enable git prompt
if [ -f ${GIT_COMPLETE} ] && [ -f ${GIT_PROMPT} ]; then
	source ${GIT_COMPLETE}
	source ${GIT_PROMPT}
	export PS1="${Blue}\h${ColorOff} ${Yellow}[ \w ]${ColorOff} ${Cyan}"'$(__git_ps1 "(%s)")'"${ColorOff} ${BPurple}\$${ColorOff} "
else
	export PS1="${Blue}\h${ColorOff} ${Yellow}[ \w ]${ColorOff} ${BPurple}\$${ColorOff} "
fi

PATH="/usr/local/bin:${PATH}"

# show stupid cow banner
fortune | cowsay
