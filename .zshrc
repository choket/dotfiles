# Prompt
PROMPT="[%*] [%F{red}%n%f] [%F{blue}%~%f] %# "

# Treat the following chars as part of a word, i.e. don't break on them
# when doing Ctrl-Backspace or Ctrl-Arrow
WORDCHARS=$'\'"*?_[]~=&;!#$%^(){}<>|'

######################### <env_vars> #################################
# Export PATH$
export PATH=~/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:$PATH

export PATH=$PATH:$HOME/go/bin
export VISUAL=vim
export EDITOR="$VISUAL"

######################### <env_vars> #################################
####################  <auto_completion>  #############################
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Select all suggestion instead of top on result only
zstyle ':autocomplete:tab:*' insert-unambiguous yes
zstyle ':autocomplete:tab:*' widget-style menu-select
zstyle ':autocomplete:*' min-input 2
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'

####################  </auto_completion>  ############################



# Fish like syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh



############################ <history> ###############################
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
export HISTTIMEOFRMAT="[%F %T]"

# Append, don't overwrite the histfile
setopt APPEND_HISTORY

# Share history across sessions
setopt SHARE_HISTORY

# Skip duplicates when searching through history
setopt HIST_FIND_NO_DUPS

# Add commands to HISTFILE as soon as they are executed
setopt INC_APPEND_HISTORY

# Also write the date and time to the histfile
setopt EXTENDED_HISTORY

############################ </history> ##############################

############################ <.inputrc> ##############################

# Ctrl-Space to complete autosuggestion
bindkey '^ ' autosuggest-accept
#
# Ctrl-Backspace to delete a whole word
bindkey '^H' backward-kill-word

# Ctrl-Del to delete a whole word
bindkey '^[[3;5~' kill-word

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Set a bash-like history
bindkey $key[Up] up-line-or-history
bindkey $key[Down] down-line-or-history

# Enable Alt-Period, Ctrl-R and other bash-like shortcuts 
bindkey -e

############################ </.inputrc> #############################

############################### <alias> ##############################
alias ls='ls -Alh --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Make ffuf match all response codes except 404 and send found items to Burp
alias ffuf='ffuf -mc all -fc 404 -replay-proxy "http://127.0.0.1:8081"'

#Make codium work when executed as root
alias codium='codium --no-sandbox --user-data-dir /tmp/vscode'

# Show Date and time when executing history command
alias history='history -E'

############################## </alias> ##############################

# Start tmux automatically when launching a terminal
# Note that the exec means that the bash process which starts when you open the terminal is replaced by tmux,
# so Ctrl-B D (i.e. disconnect from tmux) actually closes the window, instead of returning to the original bash process
# , which is probably the behaviour you want?
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  #exec tmux
  tmux
fi

