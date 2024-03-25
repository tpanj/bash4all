#!/usr/bin/bash

FILE=~/.bash4all/modes/pkg.mode.bash

_usage() {
    echo "usage: (DISTRIBS in any order; use autocompletion) e.g." _FROM_OS_ _TO_OS_ _optional_BASH4ALL_
}
_aliases_full() {
    cat $FILE | sed -n "1,/if \[ $1 =/d;/^fi$/q;p"
}
_aliases_distrib() {
    _aliases_full $1 | sed 's/^alias\W\+//;s/\W\?=.*$//'
}
_alias_distrib() {
    _aliases_full $2 | grep -oP "^alias\W+$1\W?=?\K.*$"
}

_pkg_from_to() {
    declare -a H aliasesAll aliasesRow
    declare -A lenMax al
    for e in $( cat $FILE |grep -oP '\w+(?=\s+=\s+"\$BASED")' ); do
        i=0
        for ARGV in $@; do
            if [ $ARGV = $e ]; then
                H[$i]=$e
            elif [ BASH4ALL = "$ARGV" ]; then
                H[$i]="BASH4ALL"
            fi
            ((i++))
        done
    done
    if [ ${#H[@]} -lt 1 ]; then _usage; return; fi
    IFS=","
    for d in ${H[@]}; do
        lenMax[$d]=0
        while read -r SHORT ALIAS; do
            aliasesAll+=($SHORT)
            if [ BASH4ALL = "$d" ]; then
                lenMax[$d]=10
            else
                if [ ${#ALIAS} -gt ${lenMax[$d]} ]; then lenMax[$d]=${#ALIAS}; fi
            fi
        done < <(_aliases_full $d | sed 's/^alias\W\+//;s/=/,/' && echo I)
        ((lenMax[$d]--))
    done
    while read -r asu; do
    aliasesRow+=($asu)
    done < <(for a in ${aliasesAll[@]}; do echo $a; done | sort -u)
        unset IFS
        for a in HeaD LinE ${aliasesRow[@]}; do
        col=1
        for d in ${H[@]}; do
            if [ BASH4ALL = "$d" ]; then
                v=$a
            else
                v=$(_alias_distrib $a $d | sed "s/'//g")
            fi
            if [ LinE = "$a" ]; then
                DELIM="+";
                v=$(printf '%0.s-' $(for ((i=0; i<=${lenMax[$d]}; i++)); do echo $i;done))
            elif [ HeaD = "$a" ]; then
                DELIM="|"; v="$d"
            else
                DELIM="|";
            fi
            if [ LinE = "$a" ]; then
                printf "%*s" "${lenMax[$d]}" "$v"
            else
                printf "%*s " "${lenMax[$d]}" "$v"
            fi
            if [ $col -lt ${#H[@]} ]; then echo -n $DELIM; fi
            ((col++))
        done
        echo
    done
}

how-in() {
    if [ $# -lt 2 ]; then
        _usage
    else
        _pkg_from_to $@
    fi
}

complete -W $'$( cat ~/.bash4all/modes/pkg.mode.bash |grep -oP \'\w+(?=\s+=\s+"\$BASED")\' ) BASH4ALL' how-in 
