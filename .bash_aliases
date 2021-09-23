alias arel=". ~/.bash_aliases"
alias konsole="konsole > /dev/null 2>&1 &"
pushd () {
    command pushd "$@" > /dev/null
}
popd () {
    command popd "$@" > /dev/null
}
scode(){
  echo 'y' | /snap/bin/code `realpath ${@:-.}` > /dev/null 2>&1 &
}
e(){
  echo 'y' | /snap/bin/code `realpath ${@:-.}` > /dev/null 2>&1 &
}
ride(){
  rider `realpath ${@:-.}` > /dev/null 2>&1 &
}
ws(){
  webstorm `realpath ${@:-.}` > /dev/null 2>&1 &
}
py(){
  pycharm-professional `realpath ${@:-.}` > /dev/null 2>&1 &
}
idea(){
  intellij-idea-ultimate `realpath ${@:-.}` > /dev/null 2>&1 &
}
rbm(){
  rubymine `realpath ${@:-.}` > /dev/null 2>&1 & 
}
scale(){ 
  export GDK_SCALE=$1 
}
alias cls=clear
alias gitex="~/gitex/gitext.sh > /dev/null 2>&1"
sysctl(){
 sudo systemctl $@
}
aptget(){
 sudo apt-get $@ -y 
}
svi(){
 sudo vi $@	
}
chrome(){
  google-chrome-stable $@ > /dev/null 2>&1 &
}
edge(){
  microsoft-edge-beta $@ > /dev/null 2>&1 &
}
alias d="export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0"
alias s=". ~/.bashrc"
ff(){
  find . -name "*" -type f | xargs -I {} grep -nH $1 {}
}
sff(){
  sudo find . -name "*" -type f | sudo xargs -I {} grep -nH $1 {}
}
pskill(){
  ps -ef | grep $1 | grep -v grep | awk '{print $2}' | xargs -I {} kill -9 {}
}
sgit(){
  ~/smartgit/bin/smartgit.sh $1	
}
alias sgit="~/smartgit/bin/smartgit.sh"
alias ports="sudo lsof -i -P -n | grep LISTEN"
db(){
  docker build --compress $@
}
dr(){
  docker run -it $@
}
dc(){
  docker-compose $@	
}
dnb(){
  dotnet build $@	
}
dnc(){
  dotnet build -p:RunNodePipeline=true $@	
}
dcopy(){
  mkdir -p $2
  tar cf - $1 | pv -s `du -sh $1 | awk '{print $1}'` | (cd $2; tar xf -)
}
pods(){
  kubectl --context bringg-$1 get po
}
epod(){
  kubectl --context bringg-$1 exec -ti $2 -- sh
}
tredis(){
  kubectl --context bringg-$1 port-forward svc/redis-tokens-master $2:6379 -nredis
}

gray(){
  (set -o pipefail;"$@" 2>&1>&3|sed $'s,.*,\e[91m&\e[m,'>&2)3>&1 | sed $'s,.*,\e[90m&\e[m,'
}

plas(){
  p=$1
  shift  
  plasmawindowed org.kde.plasma.$p $@	
}

alias pd="popd"
alias sim="pushd ~/work/similarweb/similarweb"
alias sw2="pushd ~/work/similarweb/sw2"
alias sw3="pushd ~/work/similarweb/sw3"
alias pro="pushd ~/work/similarweb/similarweb/Pro.SimilarWeb/SimilarWebPro.Website"
alias lite="pushd ~/work/similarweb/similarweb/Lite.SimilarWeb/Website"
alias sec="pushd ~/work/similarweb/similarweb/Secure.SimilarWeb/SimilarWeb.Secure"
alias acc="pushd ~/work/similarweb/similarweb/Secure.SimilarWeb/SimilarWeb.Account"
alias siset="systemsettings5"
alias nau="nautilus"
alias dol="dolphin"
alias pla="kpackagetool5 --list --type Plasma/Applet -g"
alias poc="pushd ~/work/similarweb/poc"
alias shop="pushd ~/work/similarweb/custom-industry"
ff(){
  find . -name "$1"
}

pstage(){
  git commit --amend -m "[skip tests]"
  git push --force origin $(git rev-parse --abbrev-ref HEAD):staging
}

upgrade(){
  aptget update 
  aptget upgrade
}
