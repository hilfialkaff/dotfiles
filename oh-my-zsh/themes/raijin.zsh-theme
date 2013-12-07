# Machine name.
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

# Directory info.
local current_dir='${PWD/#$HOME/~}'

# Git info.
local git_info='%{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%}'
ZSH_THEME_GIT_PROMPT_PREFIX="<"
ZSH_THEME_GIT_PROMPT_SUFFIX=">%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=":%{$fg[red]%}x%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=":%{$fg[green]%}o%{$fg[blue]%}"

# Prompt format: \n # USER at MACHINE in DIRECTORY on git:BRANCH STATE [TIME] \n $ 
PROMPT="
%{$terminfo[bold]$fg[yellow]%}${current_dir}%{$reset_color%} \
${git_info}
%{$fg_bold[cyan]%}%n\
%{$fg_bold[red]%}@\
%{$fg_bold[cyan]%}$(box_name)\
%{$fg_bold[magenta]%}(%?)\
%{$fg_bold[white]%}: %{$reset_color%}"
