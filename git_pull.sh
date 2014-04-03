#! /bin/bash

function git_puller {
  pwd
  if [ `ls -a | grep -c \.git$` -ne 0 ];
    then
      # these lines respond to username and password prompts. If you prefer to enter this manually, remove the expect command and args and replace with git pull
      expect -c "
      spawn git pull
expect -nocase \"Username for 'https://github.com':\"; send \"$USR\r\"
expect -nocase \"Password for\" ; send \"$PASS\r\"; interact
" 2> /dev/null # this silences errors caused when github does not prompt for username and password. If you want errors to show up, remove the redirect
    else
      SAVEIFS=$IFS
      IFS=$(echo -en "\n\b") # without this line the script breaks on directories with spaces in the name
      for i in $(ls -d */); 
      do
        cd ./"$i"
        git_puller #recursive search
        cd ..
      done
      IFS=$SAVEIFS
  fi

}


USR="GITHUBUSERNAME"
PASS="GITHUBPASSWORD"

MASTERFOLDER="$HOME/Desktop" #the folder you want to search
cd $MASTERFOLDER

git_puller