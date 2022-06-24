shopt -s expand_aliases
alias ls='exa -lgh --color=always --group-directories-first --icons'
alias diff='diff --color=always'
#alias bdr='kdesrc-build --no-src dolphin'
alias bdr='kdesrc-build --no-src kdeconnect-kde'
#alias rdb='kdesrc-run dolphin'
alias rdb='source ~/kde/build/network/kdeconnect-kde/prefix.sh && ~/kde/usr/bin/kdeconnect-sms'
alias bar='bdr && rdb'
#alias testd='source ~/kde/build/system/dolphin/prefix.sh && gdb ~/kde/usr/bin/dolphin'
alias ag='ag --silent'
alias info='info --vi-keys'
alias lsblk='lsblk -o name,fstype,size,fssize,fsused,fsuse%,label,mountpoints'
