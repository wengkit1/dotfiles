#!/bin/bash

set -e

# Configuration
DOTFILES_REPO="https://github.com/wengkit1/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

echo "Setting up development environment..."

# Clone dotfiles repo if it doesn't exist
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles repository..."
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  echo "Dotfiles directory already exists, pulling latest changes..."
  cd "$DOTFILES_DIR" && git pull
fi

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install tools
echo "Installing tools..."
tools=(
  "neovim"
  "starship"
  "zoxide"
  "fzf"
  "zsh-autosuggestions"
  "stow"
  "tmux"
  "ncspot"
  "ghostty"
  "ripgrep"
  "fd"
  "git-lfs"
  "node"
  "python@3.12"
)

for tool in "${tools[@]}"; do
  brew list "$tool" &>/dev/null || brew install "$tool"
done

# Install fonts
echo "Installing fonts..."
brew install --cask font-jetbrains-mono-nerd-font 2>/dev/null || true

# Install mambaforge
#if [ ! -d "$HOME/mambaforge" ]; then
#  echo "Installing mambaforge..."
#  curl -L -o "~/mambaforge.sh" "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-MacOSX-arm64.sh"
#  bash "~/mambaforge.sh" -b -p "$HOME/mambaforge"
#  rm "~/mambaforge.sh"
#fi

# Set up fzf
[ ! -f "$HOME/.fzf.zsh" ] && $(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc

# Stow dotfiles
echo "Creating symlinks..."
cd "$DOTFILES_DIR"
stow .

# Configure zshrc
echo "Configuring zsh..."
[ ! -f "$HOME/.zshrc" ] && touch "$HOME/.zshrc"

# Add shell configuration if not present
if ! grep -q "starship init zsh" "$HOME/.zshrc"; then
  cat >>"$HOME/.zshrc" <<'EOF'

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
EOF
fi

# Add conda initialization if not present
if [ -d "$HOME/mambaforge" ] && ! grep -q "conda initialize" "$HOME/.zshrc"; then
  cat >>"$HOME/.zshrc" <<'EOF'

# >>> conda initialize >>>
__conda_setup="$('$HOME/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/mambaforge/etc/profile.d/conda.sh" ]; then
        . "$HOME/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "$HOME/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "$HOME/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<
EOF
fi

echo "Setup complete. Restart shell or run: source ~/.zshrc"
