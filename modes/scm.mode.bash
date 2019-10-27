unalias gcl co st gb branch gob add revert pull push log 2>/dev/null

if [[ -z "$1" ]]; then
_SCM=git
else
_SCM="$1"
fi
export PS_MODE="${_MODE}-${_SCM}"

case "$_SCM" in
  git)
    unalias gcl gst gbra gco gcob gadd gcom gc gl gpus gpus glom ghom 2>/dev/null
    alias {gcl,co}='git clone'
    alias {gst,st}='git status'
    alias {gbra,gb,branch}='git branch'
    alias {gco,revert}='git checkout'
    alias {gcob,gob}='git checkout -b'
    alias {gadd,add}='git add '
    alias {gcom,gc}='git commit'
    alias {gpul,pull}='git pull'
    alias {gl,log}='git log'
    alias {gpus,push}='git push'
    alias glom='git pull origin master'
    alias ghom='git push origin master'
    ;;
  svn)
    unalias sco sst sadd svu sbr svc commit sl 2>/dev/null
    alias {sco,co}='svn checkout'
    alias {sst,st}='svn status'
    alias {sadd,add}='svn add '
    alias {svu,pull}='svn update'
    alias {sbr,branch}='svn tav'
    alias revert='svn revert'
    alias {svc,commit,push}='svn commit'
    alias {sl,log}='svn log'
    ;;
  *)
    echo "Unknown ${_MODE} or not implemented"
    PS1="$_PS_MODE"
    unset _MODE _PS_MODE PS_MODE
esac
