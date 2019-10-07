#!/bin/bash
REPOS="git@github.com:adobe/helix-static.git git@github.com:adobe/helix-example-advanced.git git@github.com:adobe/helix-log.git"

[[ -d checkouts ]] || mkdir checkouts 
pushd checkouts
for repo in $REPOS
do
  folder=$(echo $repo | sed 's/.*\///' | sed 's/\.git//')
  echo "Git repo: $repo"
  if [[ -d $folder ]] 
  then
    pushd $folder
    git pull origin master
  else
    git clone $repo
    pushd $folder
  fi
  echo "******** TESTING $(basename $(pwd))"
  npm install .
  npm test
  popd
done
popd