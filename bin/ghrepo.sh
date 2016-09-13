#!/bin/bash

echo "Create a new repo on Github"

echo "Enter OTP Code"
read ghotp

repo=$(basename $PWD)
#ghuser=$(git config --get github.user)
ghuser="bob"

echo $repo
echo "{\"name\":\"$repo\"}"



#curl -u $ghuser -H "X-GitHub-OTP:" $ghotp -d '{"name":$repo}' https://api.github.com/$ghuser/repos
#git remote add origin git@github.com:$ghuser/$repo.git
#git push origin master
