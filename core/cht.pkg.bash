_aliases_pkg__distrib() {
    cat ~/.bash4all/modes/pkg.mode.bash | sed -n "1,/if \[ $1 =/d;/^fi$/q;p"
}

_aliases_pkg_distrib() {
    _aliases_pkg__distrib $1 | sed 's/^alias\W\+//;s/\W\?=.*$//'
}

_pkg_from_to() {
    local IFS=","
    local FROM_ML=10 TO_ML=10 # Max Lengths
    declare -A FROM TO
    while read -r SHORT ALIAS ; do
        FROM["$SHORT"]=${ALIAS//\'}
        if [ ${#ALIAS} -gt ${FROM_ML} ]; then FROM_ML=${#ALIAS}; fi
    done < <(_aliases_pkg__distrib $1 | sed 's/^alias\W\+//;s/=/,/')
    while read -r SHORT ALIAS ; do
        TO["$SHORT"]=${ALIAS//\'}
        if [[ ${#ALIAS} -gt ${TO_ML} ]]; then TO_ML=${#ALIAS}; fi
    done < <(_aliases_pkg__distrib $2 | sed 's/^alias\W\+//;s/=/,/')
    unset IFS
    PLUS1=$((12+$FROM_ML))
    printf "%8s | %*s | %*s\n" "BASH4ALL" $FROM_ML $1 $TO_ML $2
    echo '---------+--------------------------------------------------------------------------------' | sed "s/\(.\{$PLUS1\}\)/\1+/"
    for a in $( sort -u <(_aliases_pkg_distrib $1) <(_aliases_pkg_distrib $2) ); do
        printf "%8s | %*s | %*s \n" $a $FROM_ML "${FROM[$a]}" $TO_ML "${TO[$a]}"
    done
}

how-in() {
    if [ $# -lt 1 ]; then
        echo usage _FROM_OS_ _TO_OS_ _optional_DOMAIN_
    else
        _pkg_from_to $@
    fi
}
