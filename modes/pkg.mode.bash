# A-Z Sorted. Alias content always in single quotes
unalias I i Qf q S se U u 2>/dev/null

if [ ARCH = "$BASED" ]; then
alias I='sudo pacman -Syu --needed'
alias i='sudo pacman -S --needed'
alias Pkg='makepkg -fp PKGBUILD'
alias Qf='sudo pacman -Fyl'
alias q='pacman -Qi'
alias se='pacman -Ss'
alias U='sudo pacman -Rys'
alias u='sudo pacman -Rs'
fi

if [ BEOS = "$BASED" ]; then
alias I='pkgman install -y'
alias i='pkgman install'
alias se='pkgman search'
alias U='pkgman uninstall -y'
alias u='pkgman uninstall'
fi

if [ BSD = "$BASED" ]; then
alias I='sudo pkg install -y'
alias i='sudo pkg install'
alias q='pkg info'
alias se='pkg search'
alias U='sudo pkg remove -y'
alias u='sudo pkg remove'
fi

if [ DEBIAN = "$BASED" ]; then
alias I='sudo apt-get -y install'
alias i='sudo apt-get install'
alias Pkg='dpkg-buildpackage --no-sign'
alias Qf='apt-file search'
alias q='apt show'
alias S='sudo service'
alias se='apt search'
alias U='sudo apt-get -y remove'
alias u='sudo apt-get remove'
fi

if [ GENTOO = "$BASED" ]; then
alias I='emerge -a'
alias i='emerge'
alias Qf='pfl'
alias q='emerge -S'
alias se='emerge -S'
alias U='emerge -avc'
alias u='emerge -vc'
fi

if [ MAC = "$BASED" ]; then
alias I='brew install'
fi

# add user to wheel group; now also moving to dnf
if [ MAGEIA = "$BASED" ]; then
alias I='sudo urpmi --no-recommends --auto'
alias i='sudo urpmi --no-recommends'
alias Pkg='rpmbuild -bb'
alias Qf='urpmf' # outputs package:file
alias q='urpmq -i'
alias S='sudo service'
alias se='urpmf --summary' # outputs package:summary
alias U='sudo urpme --auto'
alias u='sudo urpme'
fi

if [ REDHAT = "$BASED" ]; then
alias I='sudo dnf install -y'
alias i='sudo dnf install'
alias Qf='dnf provides'
alias q='dnf info'
alias S='sudo service'
alias se='dnf info'
alias U='sudo dnf remove -y'
alias u='sudo dnf remove'
fi

if [ SUSE = "$BASED" ]; then
alias I='sudo zypper install -y'
alias i='sudo zypper install'
alias Qf='zypper info'
alias q='zypper what-provides'
alias S='sudo service'
alias se='zypper search'
alias U='zypper remove -y'
alias u='zypper remove'
fi

# autocomplete aliases
if [ -f ~/.bash4all/core/bash_completion.sh ]; then
  type _complete_alias >/dev/null 2>&1
  if [ $? = 1 ]; then . ~/.bash4all/core/bash_completion.sh; fi
  for c in I i Qf q S se U u; do
    complete -F _complete_alias $c
  done
fi
