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
newfile()
{
    touch $1
    printf "/**
 * SPDX-FileCopyrightText: 2022 Jordan Bucklin <jordan.bucklin@gmail.com>
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */\n" > $1
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
