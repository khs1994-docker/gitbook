#!/bin/sh

START=`date "+%F %T"`

if [ $1 = "sh" ];then sh ; exit 0; fi

rm -rf node_modules _book

cp -a . ../gitbook

cd ../gitbook

main(){
  case $1 in
    server )
      gitbook serve
      exit 0
      ;;
    deploy )
      gitbook build
      cd _book
      git init
      git remote add origin ${GIT_REPO}
      git add .
      COMMIT=`date "+%F %T"`
      git commit -m "${COMMIT}"
      if [ -z ${BRANCH} ];then
        git push -f master
      else
        git push -f master:${BRANCH}
      fi
      ;;
    * )
      gitbook build
      ;;
    esac
    cp -a _book ../gitbook-src
    echo $START
    date "+%F %T"
}

main $1 $2 $3