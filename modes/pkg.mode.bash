# A-Z Sorted.
unalias I i U u S se Qf q 2>/dev/null

if [ ARCH = "$BASED" ]; then
alias I='pacman -Syu'
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
alias se='pkg search'
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

if [ FEDORA = "$BASED" ]; then
alias I='sudo dnf install'
fi

if [ MAC = "$BASED" ]; then
alias I='brew install'
fi

# run for root
if [ MAGEIA = "$BASED" ]; then
alias I='urpmi --no-recommends --auto'
alias i='urpmi --no-recommends'
alias u='urpme'
alias S='service'
alias se='urpmf --summary' # outputs package:summary
alias Qf='urpmf' # outputs package:file
alias q='urpmq -i'
fi

if [ REDHAT = "$BASED" ]; then
alias I='sudo yum install'
fi

if [ SUSE = "$BASED" ]; then
alias I='sudo zypper install'
fi
