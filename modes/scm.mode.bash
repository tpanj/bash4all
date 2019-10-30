unalias gcl co st sd gb branch gob add commit revert pull push log 2>/dev/null

if [[ -z "$1" ]]; then
_SCM=git
else
_SCM="$1"
fi
export PS_MODE="${_MODE}-${_SCM}"

case "$_SCM" in
  bzr)
    alias st='bzr status'
    alias branch='bzr branch'
    alias revert='bzr checkout'
    alias sd='bzr diff'
    alias add='bzr add '
    alias commit='bzr commit'
    alias pull='bzr pull'
    alias log='bzr log'
    alias push='bzr push'    ;;
  git)
    unalias gcl gst gbra gco gcob gadd gcom gc gl gpus gpus glom ghom 2>/dev/null
    alias {gcl,co}='git clone'
    alias {gst,st}='git status'
    alias {gbra,gb,branch}='git branch'
    alias {gco,revert}='git checkout'
    alias {gcob,gob}='git checkout -b'
    alias sd='git diff'
    alias {gadd,add}='git add '
    alias {gcom,gc,commit}='git commit'
    alias {gpul,pull}='git pull'
    alias {gl,log}='git log'
    alias {gpus,push}='git push'
    alias glom='git pull origin master'
    alias ghom='git push origin master'
    ;;
  hg) # mercurial
    alias st='hg status'
    alias branch='hg branch'
    alias revert='hg checkout'
    alias sd='hg diff'
    alias add='hg add '
    alias commit='hg commit'
    alias pull='hg pull'
    alias log='hg log'
    alias push='hg push'
    ;;
  svn)
    unalias sco sst sadd svu sbr svc commit sl 2>/dev/null
    alias {sco,co}='svn checkout'
    alias {sst,st}='svn status'
    alias {sadd,add}='svn add'
    alias sd='svn diff'
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
