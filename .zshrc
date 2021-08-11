# Prompt
PROMPT="[%*] [%F{red}%n%f] [%F{blue}%~%f] %# "

# Treat the following chars as part of a word, i.e. don't break on them
# when doing Ctrl-Backspace or Ctrl-Arrow
WORDCHARS=$'*?_[]~=&;!#$%^(){}<>|'

######################### <env_vars> #################################
# Export PATH$
export PATH=~/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:$PATH

export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.cargo/bin
export VISUAL=vim
export EDITOR="$VISUAL"
export GIT_EDITOR='vim +startinsert'

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
export HISTTIMEFORMAT="[%F %T]"

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
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history

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

alias clip='xclip -sel c -r; xclip -sel c -o | xclip -sel p'

############################## </alias> ##############################

# Start tmux automatically when launching a terminal
# Note that the exec means that the bash process which starts when you open the terminal is replaced by tmux,
# so Ctrl-B D (i.e. disconnect from tmux) actually closes the window, instead of returning to the original bash process
# , which is probably the behaviour you want?
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  #exec tmux
  tmux
fi

# Log the terminal's output to a file if $ENABLE_LOGGING is set to 1.
if command -v script &> /dev/null && [[ "$ENABLE_LOGGING" == 1 ]] && [ -z "$IS_CURRENTLY_LOGGING" ] ; then
  # Get the log directory from $LOG_DIRECTORY or default to "$PWD/terminal_logs"
  log_directory=${LOG_DIRECTORY:-$PWD/terminal_logs}
  mkdir -p "$log_directory"

  if [[ -z "$LOG_DIRECTORY" ]]; then
    echo "WARNING: Logging is enabled but LOG_DIRECTORY is not set."
	echo "All logs will be written to $log_directory"
  fi

  if [ "$TMUX" ] ; then
    tmux_session=$(tmux display-message -p '#S')
    output_file="$tmux_session-$TMUX_PANE-$(head /dev/random | tr -dc A-Za-z0-9 | head -c15).log"
  else
    output_file="$(head /dev/random | tr -dc A-Za-z0-9 | head -c15).log"
  fi
  
  #exec script -f -q -c 'ZSH_RUN_AS_INTERACTIVE=1 IS_CURRENTLY_LOGGING=1 zsh' "$log_directory/$output_file"
 
  # Log pane output to a file everytime a zsh prompt is shown
  if [ "$TMUX" ] ; then
    precmd() {
      ( tmux capture-pane -e -J -p -t $(echo $TMUX_PANE) -S - -E - > "$log_directory/$output_file" & )
    }
  fi 
fi

