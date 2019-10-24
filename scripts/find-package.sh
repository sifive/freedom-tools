#!/bin/sh
pkgname=$1
optname=$2
wdbname=$(basename `pwd`)

# Can the package (first arg) be found in this build directory
if [ -f "`pwd`/bin/$pkgname" ]
then
  echo "`pwd`/bin/$pkgname"
  exit 0
fi

# If no second arg is supplied, take the optname from the current build directory
if [ x"$optname" = x ]
then
  optname=$wdbname
fi

# We only want to get the string after the last occurence of -- if any
# as this in Jenkins CI should be the branch name
sfxname=$(echo $optname | rev | sed 's/--.*//' | rev)

# If there were no occurence of -- we will not search other directories
if [ x"$sfxname" = x"$optname" ]
then
  echo "Could not find the package in the current build directory"
  exit 1
fi

# Look in directories with matching suffix parallel to this build directory
cd ..
lstname=$(ls -d *--$sfxname)

for itmname in $lstname
do
  if [ -f "`pwd`/$itmname/bin/$pkgname" ]
  then
    echo "`pwd`/$itmname/bin/$pkgname"
    exit 0
  fi
done

echo "Could not find the package in any build directory: ../*--$sfxname"
exit 1
