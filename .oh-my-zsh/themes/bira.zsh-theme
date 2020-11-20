#zsh official theme
local current_dir='%{$fg_bold[red]%}[%{$reset_color%}%~% %{$fg_bold[red]%}]%{$reset_color%}'
local git_branch='$()%{$reset_color%}'


PROMPT="
%(?,%{$reset_color%}┌──(%n@%m)-[%(5~|%-1~/…/%2~|%4~)] ${git_branch}
%{$reset_color%}└─$ "

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="] %{$reset_color%}"
