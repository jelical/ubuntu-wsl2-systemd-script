alias gpd="globalprotect show --details"
alias gpc="globalprotect connect"
alias wsls="wsl.exe --shutdown"
alias arel=". ~/.bash_aliases"
alias al="code ~/.bash_aliases"
alias konsole="konsole > /dev/null 2>&1 &"
alias pg="pgrep -fa"
alias i="sudo apt-get install -y "
alias r="sudo apt-get remove -y "
alias up="sudo apt-get update"
alias ug="sudo apt-get upgrade"
alias aar="sudo apt autoremove -y"
alias post="postman > /dev/null 2>&1 &"
alias st="speedtest -s 46049"
alias inst="apt list --installed 2>/dev/null | sed 's=\([^/]*\)/.*=\1=g'"

shell=$(ps | grep $$ | awk '{print $4}')
if [ "$shell" = "zsh" ]; then
 autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
 add-zsh-hook chpwd chpwd_recent_dirs
 pushd(){ cd $@; }
 popd() {
  local dir=$PWD
  cdr
  cdr -P $dir
 }
 else
 pushd () {
    command pushd "$@" > /dev/null
 }
 popd () {
    command popd "$@" > /dev/null
 }
fi


iam(){
    aws_account=${1:-'operational'}
    intra aws creds --update-default-profile --mode write --update-default-profile --username ${USER} --account $aws_account --requested-team 'R&D Web'
    echo "using aws account $aws_account"
}
ustatus(){
  systemctl --user status $@
}
ustart(){
  systemctl --user start $@
}
ustop(){
  systemctl --user stop $@
}
loop(){
  num=$1;
  shift;
  for i in $(seq 1 10); do "$@"; done
}
userctl() {
  systemctl --user "$@"
}
log() {
         git log origin/master --first-parent --grep="BIS" --pretty='format:%h,%s,%cn,%ce,%as' --since="2022-01-01" | sed "s=Merge branch '==g" | sed "s=' into 'master'==g" | sed "s=\(.*\)\(BIS-[0-9]*\)\(.*\)=\1\2\3,https://similarweb-rnd.atlassian.net/browse/\2=g"
}
scode(){
  echo 'y' | /snap/bin/code `realpath ${@:-.}` > /dev/null 2>&1 &
}
storm(){
  phpstorm `realpath ${@:-.}` > /dev/null 2>&1 &
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
  microsoft-edge-stable $@ > /dev/null 2>&1 &
}
alias d="export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0"
alias s=". ~/.bashrc"
alias z=". ~/.zshrc"
ff(){
  find . -name "*" -type f | xargs -I {} grep -nH $1 {}
}
sff(){
  sudo find . -name "*" -type f | sudo xargs -I {} grep -nH $1 {}
}
pskill(){
  ps -ef | grep $1 | grep -v grep | awk '{print $2}' | xargs -I {} kill -9 {}
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
dtt(){
  dotnet test $@ --no-build -c Debug  /p:CollectCoverage=true /p:CoverletOutputFormat=Cobertura \
      --filter "TestCategory!=IntegrationTests&TestCategory!=integration&Category!=IntegrationTests&Category!=integration" \
      --test-adapter-path:. --logger:"console;verbosity=quiet" \
      --collect:"XPlat Code Coverage"
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

# docker_run_k8s(){
#   : ${AWS_ACCESS_KEY_ID:="$(cat ~/.aws/credentials | grep aws_access | sed 's/.*=[ ]*//g' | uniq)"}
#   : ${AWS_SECRET_ACCESS_KEY:="$(cat ~/.aws/credentials | grep aws_secret_access | sed 's/.*=[ ]*//g' | uniq)"}
#   : ${AWS_SESSION_TOKEN:="$(cat ~/.aws/credentials | grep aws_session_token | sed 's/.*=[ ]*//g' | uniq)"}
#   [[ -n "$AWS_SESSION_TOKEN" ]] && DOCKER_AWS_SESSION_TOKEN="-e AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN"  
#   docker run -ti \
#     -e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" \
#     -e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" \
#     ${DOCKER_AWS_SESSION_TOKEN} \
#     -e "HOME=/home/${USER}" \
#     --user 1000:1000 \
#     --net=host \
#     -v $HOME:/home/${USER} \
#     alpine/k8s:1.23.14 \
#     /bin/bash -c "cd $(pwd) && $*"
# }
# kustomize(){ docker_run_k8s kustomize $* ; }
# aws(){ docker_run_k8s aws $* ; }
# kubectl(){ docker_run_k8s kubectl $* ; }
# helm(){ docker_run_k8s helm $* ;}

alias pd="popd"
alias cli="pushd ~/work/similarweb/pro-frontend-client"
alias sim="pushd ~/work/similarweb/similarweb"
alias sw2="pushd ~/work/similarweb/sw2"
alias corp="pushd ~/work/similarweb/sw-cms-corp"
alias sw3="pushd ~/work/similarweb/sw3"
alias pro="pushd ~/work/similarweb/similarweb/Pro.SimilarWeb/SimilarWebPro.Website"
alias lite="pushd ~/work/similarweb/similarweb/Lite.SimilarWeb/Website"
alias sec="pushd ~/work/similarweb/similarweb/Secure.SimilarWeb/SimilarWeb.Secure"
alias acc="pushd ~/work/similarweb/similarweb/Secure.SimilarWeb/SimilarWeb.Account"
alias siset="systemsettings5"
alias nau="nautilus"
alias dol="dolphin"
alias poc="pushd ~/work/similarweb/poc"
alias shop="pushd ~/work/similarweb/shopper-platform"
alias inv="pushd ~/work/similarweb/investors-intelligence"

ff(){
  find . -name "$1"
}
ffg(){
  find . -name "$1" | grep "$2"	
}

upgrade(){
  aptget update
  aptget upgrade
}

alias intravert="intra aws creds --username ${USER} --mode write --update-default-profile --requested-team \"R&D Web\""
