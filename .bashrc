#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# Git completion (this is really nice!)
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
fi

# For creating a new template file
# $1 : the filename to create
newfile()
{
    touch $1
    printf "/**
 * SPDX-FileCopyrightText: 2022 Jordan Bucklin <jordan.bucklin@gmail.com>
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */\n" > $1
}

# On login, give a reminder to clean the pacman cache
# if it has exceeded 30G
if [[ $(du -sht 30G /var/cache/pacman) != "" ]]; then
    echo "Pacman cache is at $(sizeof /var/cache/pacman | cut -d'/' -f1 | tr -d '\t'). Consider running pacclean."
fi

# Cleans the pacman cache, keeping only the 2 most recent
# package versions.
pacclean()
{
    echo "WARNING: cleaning pacman cache. Only retaining past two versions of each package."
    printf "Continue? (y/N): "
    read CONFIRM
    if [[ $CONFIRM == "y" ]]; then
        sudo paccache -rk2
        echo "Pacman cache cleaning complete."
    fi
}

############################ kdesrc-build ########################################

## Add kdesrc-build to PATH
export PATH="$HOME/kde/src/kdesrc-build:$PATH"

## Autocomplete for kdesrc-run
function _comp-kdesrc-run
{
  local cur
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"

  # Complete only the first argument
  if [[ $COMP_CWORD != 1 ]]; then
    return 0
  fi

  # Retrieve build modules through kdesrc-run
  # If the exit status indicates failure, set the wordlist empty to avoid
  # unrelated messages.
  local modules
  if ! modules=$(kdesrc-run --list-installed);
  then
      modules=""
  fi

  # Return completions that match the current word
  COMPREPLY=( $(compgen -W "${modules}" -- "$cur") )

  return 0
}

## Register autocomplete function
complete -o nospace -F _comp-kdesrc-run kdesrc-run

################################################################################
