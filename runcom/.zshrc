# Profiling zsh shell scripts
# zmodload zsh/zprof

# If not running interactively, don't do anything

[ -z "$PS1" ] && return

# Resolve DOTFILES_DIR (assuming ~/.dotfiles on distros without readlink and/or $BASH_SOURCE/$0)
CURRENT_SCRIPT=${BASH_SOURCE:-$0}

if [[ -n $CURRENT_SCRIPT && -x readlink ]]; then
  SCRIPT_PATH=$(readlink -n $CURRENT_SCRIPT)
  DOTFILES_DIR="${PWD}/$(dirname $(dirname $SCRIPT_PATH))"
elif [ -d "$HOME/.dotfiles" ]; then
  DOTFILES_DIR="$HOME/.dotfiles"
else
  echo "Unable to find dotfiles, exiting."
  return
fi

# Make utilities available

PATH="$DOTFILES_DIR/bin:$PATH"

# Source the dotfiles (order matters)

for DOTFILE in "$DOTFILES_DIR"/system/.{function,function_*,path,env,exports,alias,fnm,grep,prompt,completion,fix,zoxide,aliases,functions}; do
  . "$DOTFILE"
done

if is-macos; then
  for DOTFILE in "$DOTFILES_DIR"/system/.{env,alias,function}.macos; do
    . "$DOTFILE"
  done
fi

eval "$(dircolors -b "$DOTFILES_DIR"/system/.dir_colors)"

# Wrap up

unset CURRENT_SCRIPT SCRIPT_PATH DOTFILE
export DOTFILES_DIR

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  # archive
  # aws
  # bower
  brew
  # bundler
  docker
  # extract
  git
  git-extras
  helm
  kubectl
  macos
  pass
  # sublime
  terraform
  # vagrant
  vault
  vscode
  z
)

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

#ZSH_THEME="avit"
#ZSH_THEME="random"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# ZSH_THEME_RANDOM_BLACKLIST=(pygmalion tjkirch_mod)

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

source $ZSH/oh-my-zsh.sh

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# User config.
source ~/.zsh/setopt.zsh

# dircolors.
if [ -x "$(command -v dircolors)" ]; then
    eval "$(dircolors -b ~/.dircolors)"
fi

# Manage SSH with Keychain.
if [ -x "$(command -v keychain)" ]; then
    eval "$(keychain --eval --quiet id_rsa_github id_rsa_gitlab)"
fi

# Base16 Shell.
if [ -f ~/.local/bin/base16-oxide ]; then
    source ~/.local/bin/base16-oxide
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Profiling zsh shell scripts finish
# zprof
export DIRENV_LOG_FORMAT=
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="$HOME/.helm:$PATH"
source $HOME/.helm/helmenv.sh
export PATH="${PATH}:${HOME}/.krew/bin"

export TF_VERSION=0.11.14
terraformer() { docker run --rm -it -v $(pwd):/cfg -v ~/.aws:/.aws tmhub.io/ticketmaster/terraformer:$TF_VERSION "$@"; }
eval "$(fnm env --use-on-cd)"

