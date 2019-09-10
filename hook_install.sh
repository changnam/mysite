#! /usr/bin/env bash

echo "Installing client hooks for proj3 ."

SCRIPT_PATH=$(dirname `which $0`)
#echo $SCRIPT_PATH

ln -s $SCRIPT_PATH/hooks/commit-msg $SCRIPT_PATH/.git/hooks/commit-msg

if [ $? -eq 0 ]
then
  echo "commit-msg is sucessfully installed."
fi

SCRIPT_PATH=$(dirname `which $0`)

ln -s $SCRIPT_PATH/hooks/pre-commit $SCRIPT_PATH/.git/hooks/pre-commit

if [ $? -eq 0 ]
then
  echo "pre-commit is sucessfully installed."
fi
