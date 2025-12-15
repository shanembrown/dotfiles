#!/usr/bin/env zsh

# -- navigation ----------------------------------------------------------------

setopt AUTO_CD              # Go to folder path without using cd

setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt NO_CASE_GLOB         #setopt GLOB_COMPLETE

# enable completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2

# -- history -------------------------------------------------------------------

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

# -- aliases -------------------------------------------------------------------

source $HOME/.aliases

# -- functions -----------------------------------------------------------------

source $HOME/.functions

# -- prompt --------------------------------------------------------------------

# https://git-prompt-kit.olets.dev
set_prompt_vars() {
  psvar=( )
  
  git_branch=$(git branch --show-current 2>/dev/null)
  
  if [[ -n $git_branch ]]; then
    psvar+=( $git_branch )
  else
    psvar+=( $(git rev-parse --short 2>/dev/null) )
  fi
  
  if [[ $(git status --porcelain 2>/dev/null) ]]; then
    psvar+=( magenta )
  fi
}
  
autoload -Uz add-zsh-hook
add-zsh-hook precmd set_prompt_vars
  
# directory
PROMPT='%F{blue}%2~%f '
  
# Git HEAD
PROMPT+="%(2V.%F{%2v}.)%1v%f%(1V. .)"
  
# prompt char
PROMPT+='%F{%(?.green.red)}%#%f '

# -- vi mode -------------------------------------------------------------------

# enable Vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[3 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[1 q'
  fi
}

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[1 q"
}
zle -N zle-line-init
echo -ne '\e[3 q' # Use blinking block shape cursor on startup.
preexec() { echo -ne '\e[3 q' ;} # Use blinking block cursor for each new prompt.

# Set cursor style (DECSCUSR), VT520.
# 0  ⇒  blinking block.
# 1  ⇒  blinking block (default).
# 2  ⇒  steady block.
# 3  ⇒  blinking underline.
# 4  ⇒  steady underline.
# 5  ⇒  blinking bar, xterm.
# 6  ⇒  steady bar, xterm.

# -- terraform -----------------------------------------------------------------

export TF_CLI_ARGS_apply="-parallelism=1"


# -- fzf -----------------------------------------------------------------------

export FZF_DEFAULT_OPTS=" \
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"

# -- bat -----
export BAT_CONFIG_PATH="$HOME/.config/bat/bat.conf"
