
# Terminal title
DISABLE_AUTO_TITLE="true"
function precmd () {
    echo -ne "\033]0;$(basename "$PWD")\007"
}

# Paths
export PATH="/opt/homebrew/bin:/usr/bin:/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null || echo "")

# Shell enhancements
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey '\ec' fzf-cd-widget
