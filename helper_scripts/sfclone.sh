#!/bin/bash

if [[ $# -eq 0 ]] ; then
  echo 'Repo name required'
  exit 1
fi

git clone git@github.com:stitchfix/$1.git
