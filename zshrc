autoload -U compinit promptinit colors
compinit
colors

# enable prompt substitution for git branch in prompt
setopt prompt_subst
autoload -Uz vcs_info
promptinit

# no history duplicates
setopt HIST_IGNORE_DUPS

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

PROMPT="%{$fg_bold[green]%}%m %{$fg_bold[yellow]%}%~$git_prompt%{$fg_bold[magenta]%}$ %{$reset_color%}"

# do right-prompt
RPROMPT=""

# aliases
alias ls='ls --color=auto'

if [ -f ~/.yelp_bash_alias ]; then
	source ~/.yelp_bash_alias
fi
