#!/bin/sh
####################################################################
#  Written By Glen Benson 4/8/2016
#  Updates GITHUB
#  Must have user and password already set in the global settings
#   to see global git settings enter:  nano ~/.gitconfig
#  
#   to set up user variables
#   git config --global dakabi.username  "username"
#   git config --global dakabi.password  "password"
#   git config --global dakabi.email  "emailaddress.com"
####################################################################

#-- see if there is a user name in the global settings
username=`git config dakabi.username`
if [ "$username" = "" ]; then
    echo "Could not find username, run 'git config --global github.user <username>'"
    invalid_credentials=1
fi

#-- see if there is a password in the global settings
password=`git config dakabi.password`
if [ "$password" = "" ]; then
    echo "Could not find password, run 'git config --global github.password <username>'"
    invalid_credentials=1
fi


#----------------------------------------------------------
# [OPTIONAL] copy all other needed folders into this folder 
# so they all get pushed to the same repository
# example : cp -a /root/src/. /root/alpha/src
#----------------------------------------------------------


#-- init git localy
git init

#-- add all files in the dir( . means all files)
git add .

#-- add a message for all un changed files
git commit -am "commit message"

#-- push them to github
git push https://$username:$password@github.com/glenbenson/alpha.git --all

echo " done."


