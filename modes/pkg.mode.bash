# A-Z Sorted. Alias content always in single quotes
unalias I i U u S se Qf q 2>/dev/null

if [ ARCH = "$BASED" ]; then
alias I='pacman -Syu'
alias i='pacman -S'
alias U='pacman -Rys'
alias u='pacman -Rs'
alias se='pacman -Ss'
alias Qf='pacman -Fl'
alias q='pacman -Qi'
fi

if [ BEOS = "$BASED" ]; then
alias I='pkgman install -y'
alias i='pkgman install'
alias U='pkgman uninstall -y'
alias u='pkgman uninstall'
alias se='pkgman search'
fi

if [ BSD = "$BASED" ]; then
alias I='sudo pkg install -y'
alias i='sudo pkg install'
alias U='sudo pkg remove -y'
alias u='sudo pkg remove'
alias se='pkg search'
alias q='pkg info'
fi

if [ DEBIAN = "$BASED" ]; then
alias I='sudo apt-get -y install'
alias i='sudo apt-get install'
alias U='sudo apt-get -y remove'
alias u='sudo apt-get remove'
alias S='sudo service'
alias se='apt search'
alias Qf='apt-file search'
alias q='apt show'
fi

if [ REDHAT = "$BASED" ]; then
alias I='sudo dnf install -y'
alias i='sudo dnf install'
alias U='sudo dnf remove -y'
alias u='sudo dnf remove'
alias Qf='dnf provides'
alias q='dnf info'
alias S='sudo service'
alias se='dnf info'
fi

if [ GENTOO = "$BASED" ]; then
alias I='emerge -a'
alias i='emerge'
alias U='emerge -avc'
alias u='emerge -vc'
alias se='emerge -S'
alias Qf='pfl'
alias q='emerge -S'
fi

if [ MAC = "$BASED" ]; then
alias I='brew install'
fi

# add user to wheel group; now also moving to dnf
if [ MAGEIA = "$BASED" ]; then
alias I='sudo urpmi --no-recommends --auto'
alias i='sudo urpmi --no-recommends'
alias U='sudo urpme --auto'
alias u='sudo urpme'
alias S='sudo service'
alias se='urpmf --summary' # outputs package:summary
alias Qf='urpmf' # outputs package:file
alias q='urpmq -i'
fi

if [ SUSE = "$BASED" ]; then
alias I='sudo zypper install -y'
alias i='sudo zypper install'
alias U='zypper remove -y'
alias u='zypper remove'
alias S='sudo service'
alias se='zypper search'
alias Qf='zypper info'
alias q='zypper what-provides'
fi

# autocomplete aliases
if [ -f ~/.bash4all/core/bash_completion.sh ]; then
  type _complete_alias >/dev/null 2>&1
  if [ $? = 1 ]; then . ~/.bash4all/core/bash_completion.sh; fi
  for c in I i U u S se Qf q; do
    complete -F _complete_alias $c
  done
fi
