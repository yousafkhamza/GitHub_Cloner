#!/bin/bash
# Author: Yousaf K Hamza
# Description: GitHub Repository Cloning bash Script

printf "\e[1;92m        ____ ___ _____ _   _ _   _ ____     ____ _     ___  _   _ _____ ____      \e[0m\n"
printf "\e[1;92m       / ___|_ _|_   _| | | | | | | __ )   / ___| |   / _ \| \ | | ____|  _ \     \e[0m\n"
printf "\e[1;92m      | |  _ | |  | | | |_| | | | |  _ \  | |   | |  | | | |  \| |  _| | |_) |    \e[0m\n"
printf "\e[1;92m      | |_| || |  | | |  _  | |_| | |_) | | |___| |__| |_| | |\  | |___|  _ <     \e[0m\n"
printf "\e[1;92m       \____|___| |_| |_| |_|\___/|____/   \____|_____\___/|_| \_|_____|_| \_\    \e[0m\n"

printf "\n"
printf "\e[1;77m\e[45m         GitHub Cloner v1 Author: @yousafkhamza (Github|Instagram|LinkedIn)          \e[0m\n"
printf "\n"

echo ""
echo "..................Welcome to the Script.................."
echo "Let's start to clone repos from GitHub, also, please note that the script won't download forked repos...."
echo ""

Git_User=$1
Git_Token=$2
rm -f .git_repo_list.txt

function cloner_main {
    echo "Fetched Repo list below (without forked): "
    echo "---------"
    cat .git_repo_list.txt
    echo "---------"
    repo_count=$(cat .git_repo_list.txt | wc -l)
    if [ $repo_count == 0 ];then
        echo "Can't able to Fetch user repos."
        exit 1
    fi 
    echo "Cloning starts in 10sec..." 
    echo "if you wouldn't like to clone the repos please be exit the script meanwhile the countdown using [ctrl + c]...."
    echo "Countdown Begins..."
    count=9; ((++count)) ; while ((--count >=0)); do sleep 1; echo -e "\033[31;5m$count..\033[0m"; done; #backword countdown
    echo "Cloning Starts..."
    if [ ! -d "./Clonings" ]; then
        mkdir ./Clonings
    else
        rm -f ./Clonings/.git_repo_list.txt
    fi
    cp .git_repo_list.txt ./Clonings/.git_repo_list.txt
    cd ./Clonings
    for item in $(cat .git_repo_list.txt | cut -d: -f2); do echo "-----" && git clone https://github.com/$item; done
    echo "-----" 
    echo "Cloning Completed"
    echo "Please take a look under $(pwd)/Clonings/ Directory"
    exit 1
}

if [ -z "$Git_User" ]
then
    echo "Please specify a GitHub UserName."
    exit 1
fi

# without token
if [ -z "$Git_Token" ]
then
    echo "Please specify a GitHub Token Otherwise can't able to clone your private repos."
    read -p 'Do you want to continue without private repos [Y/N]: ' ask1
    if [[ "$ask1" =~ ^([yY][eE][sS]|[yY])+$ ]];then
        curl -s "https://api.github.com/search/repositories?q=user:$Git_User&per_page=200" | grep -o 'git@[^"]*' > .git_repo_list.txt
        cloner_main
    else
        echo "Quited. Thank you for using the script."
        exit 1
    fi
fi

#if you have token
curl -s -H "Authorization: token $Git_Token" "https://api.github.com/search/repositories?q=user:$Git_User&per_page=200" | grep -o 'git@[^"]*' > .git_repo_list.txt
echo "You are entering the token so will clone the private repos too."
cloner_main

###################################################Thank_You#######################################################
