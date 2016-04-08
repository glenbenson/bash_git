#!/bin/sh
#############################################
#  Written By Glen Benson 4/8/2016
#  Creates a new repository on Github
#  !!!MUST BE RUN FROM THE PROJECT DIRECTORY
#  Modified from source at
#  https://github.com/KENJU/git_shellscript 
#
#  Must have user and password already set in the global settings
#   to see global git settings enter:  nano ~/.gitconfig
#  
#   to set up user variables
#   git config --global dakabi.username  "username"
#   git config --global dakabi.password  "password"
#   git config --global dakabi.email  "emailaddress.com"
#############################################


#-- see if there is a user name in the global settings
username=`git config dakabi.username`
if [ "$username" = "" ]; then
    echo "Could not find username, run 'git config --global dakabi.username <username>'"
    invalid_credentials=1
fi

#-- see if there is a password in the global settings
password=`git config dakabi.password`
if [ "$password" = "" ]; then
    echo "Could not find password, run 'git config --global dakabi.password <username>'"
    invalid_credentials=1
fi


# get repo name
dir_name=`basename $(pwd)`
read -p "Do you want to use '$dir_name' as a repo name?(y/n)" answer_dirname
case $answer_dirname in
  y)
    # use currently dir name as a repo name
    reponame=$dir_name
    ;;
  n)
    read -p "Enter your new repository name: " reponame
    if [ "$reponame" = "" ]; then
        reponame=$dir_name
    fi
    ;;
  *)
    ;;
esac

#----------------------------------------------------------
# [OPTIONAL] copy all other needed folders into this folder 
# so they all get pushed to the same repository
# example : cp -a /root/src/. /root/alpha/src
#----------------------------------------------------------


# create remote repo
echo "Creating Github repository '$reponame' ..."
curl -u $username:$password https://api.github.com/user/repos -d '{"name":"'$reponame'"}'
echo " done."

# create empty README.md
echo "Creating README ..."
touch README.md
echo "First Commit $reponame ">>README.md
echo " done."

# push to remote repo
echo "Pushing to remote ..."
git init
git add -A    ## adds all files

git commit -m "first commit"   ## just a message 
git remote rm origin
git remote add origin https://github.com/$username/$reponame.git
#git push -u origin master
git push https://$username:$password@github.com/glenbenson/$reponame.git --all
echo " done."


