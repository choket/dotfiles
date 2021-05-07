

# Source the ~/.zshrc file if ZSH_RUN_AS_INTERACTIVE is set to true.
# This is useful when using "script" and other similar programs which run 
# zsh in a non-interactive mode, and thus not sourcing ~/.zshrc
if [[ "$ZSH_RUN_AS_INTERACTIVE" == 1 ]]; then
    source ~/.zshrc
fi

