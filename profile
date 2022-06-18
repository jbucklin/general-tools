# /etc/profile

# Set our umask
umask 022

# Append "$1" to $PATH when not already in.
# This function API is accessible to scripts in /etc/profile.d
append_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

# Append our default paths
append_path '/usr/local/sbin'
append_path '/usr/local/bin'
append_path '/usr/bin'

# Force PATH to be environment
export PATH

# Load profiles from /etc/profile.d
if test -d /etc/profile.d/; then
	for profile in /etc/profile.d/*.sh; do
		test -r "$profile" && . "$profile"
	done
	unset profile
fi

# Unload our profile API functions
unset -f append_path

# Source global bash config, when interactive but not posix or sh mode
if test "$BASH" &&\
   test "$PS1" &&\
   test -z "$POSIXLY_CORRECT" &&\
   test "${0#-}" != sh &&\
   test -r /etc/bash.bashrc
then
	. /etc/bash.bashrc
fi

# Termcap is outdated, old, and crusty, kill it.
unset TERMCAP

# Man is much better than us at figuring this out
unset MANPATH

# Set the coloring depending on which user is logged in
RED='\[\e[0;31m\]'
GREEN='\[\e[0;32m\]'
CYAN='\[\e[0;36m\]'
ENDCLR='\[\e[m\]'
if [ $(id -u) -eq 0 ]; then # Logged in as root
    PS1="[${RED}\u${ENDCLR}@${RED}\h${ENDCLR}: ${CYAN}\w${ENDCLR}]${RED}#${ENDCLR} "
else
    PS1="[${GREEN}\u${ENDCLR}@${GREEN}\h${ENDCLR}: ${CYAN}\w${ENDLR}]${GREEN}\$${ENDCLR} "
fi
export PS1
unset RED
unset GREEN
unset CYAN
unset ENDCLR
