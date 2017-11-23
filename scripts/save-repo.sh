#!/bin/sh

echo "==== Checking current dir ..."
vCurrentDir=`dirname $0`
echo $vCurrentDir
cd $vCurrentDir

echo "==== Save to bitbucket ..."
./use-bitbucket.sh
git push

echo "==== Save to github ..."
./use-github.sh
git push
