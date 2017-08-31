#!/bin/bash

echo "This will remove: \n"
git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}'
read -p "Are you sure? (y/n)" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d
fi
