# GitHub Cloner Bash Script
[![Build](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

---
## Description
This is a simple bash script for cloning all the repositories under a GitHub user. if you're using a GitHub personal access token with repo privilege then you can clone the private repos too. Also, please note that the bash script is working with GitHub API and forked repos can't be able to download so I will be adding the same on future releases. 

----
## Feature
- Easy to clone all the repos under a GitHub User.
- Working with GitHub API.
- Private repos can clone with personal GitHub Token.

----
## Pre-Requests
- GitHub Token (if you need your personal/repos not mandatory)

#### GitHub Token Generator
> Private Repos Cloning you guys need a personal GitHub Token from your repo so please be follow the below article and create the same from your end. (Please make sure we need repo privilege)

[Click here for Token Article](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)


#### Pre-Requests (for RedHat-based-Linux)
```
yum install -y git
```

#### Pre-Requests (for Debian-based-Linux)
````
apt install -y git
````

#### Pre-Requests (for Termux-based-Linux)
````
pkg upgrade
pkg install git
````

----
## Modules Used
- [GitHub API](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)

---
## How to Get
```
git clone https://github.com/yousafkhamza/GitHub_Cloner_Bash_Script.git
cd GitHub_Cloner_Bash_Script
chmod +x cloner.sh
```

----
## How to execute
```
/bin/bash cloner.sh <USERNAME> <If you have a token please enter your GITHUB TOKEN HERE>
```

----
## Output be like
`Cloning without GitHub API token so please see the below screenshots with and without token`
```
yousaf@MSI:/mnt/c/Users/yousa/GitHub_Cloner_Bash_Script$ /bin/bash cloner.sh newakhilguru
        ____ ___ _____ _   _ _   _ ____     ____ _     ___  _   _ _____ ____
       / ___|_ _|_   _| | | | | | | __ )   / ___| |   / _ \| \ | | ____|  _ \
      | |  _ | |  | | | |_| | | | |  _ \  | |   | |  | | | |  \| |  _| | |_) |
      | |_| || |  | | |  _  | |_| | |_) | | |___| |__| |_| | |\  | |___|  _ <
       \____|___| |_| |_| |_|\___/|____/   \____|_____\___/|_| \_|_____|_| \_\

         GitHub Cloner v1 Author: @yousafkhamza (Github|Instagram|LinkedIn)


..................Welcome to the Script..................
Let's start to clone repos from GitHub, also, please note that the script won't download forked repos....

Please specify a GitHub Token Otherwise can't able to clone your private repos.
Do you want to continue without private repos [Y/N]: y
Fetched Repo list below (without forked):
---------
git@github.com:newakhilguru/newakhilguru.git
git@github.com:newakhilguru/mssqlbackup.bat.git
---------
Cloning starts in 10sec...
if you wouldn't like to clone the repos please be exit the script meanwhile the countdown using [ctrl + c]....
Countdown Begins...
9..
8..
7..
6..
5..
4..
3..
2..
1..
0..
Cloning Starts...
-----
Cloning into 'newakhilguru'...
warning: You appear to have cloned an empty repository.
-----
Cloning into 'mssqlbackup.bat'...
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), 678 bytes | 2.00 KiB/s, done.
-----
Cloning Completed
Please take a look under /mnt/c/Users/yousa/GitHub_Cloner_Bash_Script/Clonings/Clonings/ Directory
```
### _Screenshots_

`Without GitHub API Token`
![alt_txt](https://i.ibb.co/25vGxjQ/Screenshot-2.png)
![alt_txt](https://i.ibb.co/MpMjFBH/Screenshot-3.png)

`With GitHub API Token`
![alt_txt](https://i.ibb.co/0KJk7Fr/Screenshot-4.png)
![alt_txt](https://i.ibb.co/mvkxzmD/Screenshot-5.png)

----
## Behind the code
````
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
````

----
## Conclusion
This is a simple bash script for cloning all the private & public repos except forked repos under a GitHub user. I hope this would be helpful to anyone so please let me know if you have any comments.

### ⚙️ Connect with Me 

<p align="center">
<a href="mailto:yousaf.k.hamza@gmail.com"><img src="https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white"/></a>
<a href="https://www.linkedin.com/in/yousafkhamza"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white"/></a> 
<a href="https://www.instagram.com/yousafkhamza"><img src="https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white"/></a>
<a href="https://wa.me/%2B917736720639?text=This%20message%20from%20GitHub."><img src="https://img.shields.io/badge/WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white"/></a><br />
