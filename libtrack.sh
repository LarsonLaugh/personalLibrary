#!/bin/bash

source ~/personalLib/config.sh # import TARGET_DIR and DATA_FILE (change to your directory to config.sh)
git pull

# Make your life colourful
NC='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White



CURRENTDATETIME=`date +%Y-%m-%d`
CURRENTDATE=`date +%Y-%m-%d`
YESTERDAY=`date -d "24 hours ago" +%Y-%m-%d`


cd "$TARGET_DIR"


echo "Library Management for ${CURRENTDATETIME}"

# .pdf file counts 
total_files="$(find . -type f -iname '*.pdf'| wc -l)"
# files_changed="$(git status | wc -l | tr -d '[:space:]')"
files_added="$(git status | grep 'new file' | wc -l | tr -d '[:space:]')"
files_modified="$(git status | grep 'modified' | wc -l | tr -d '[:space:]')"
files_deleted="$(git status | grep 'deleted' | wc -l | tr -d '[:space:]')"
files_renamed="$(git status | grep 'renamed' | wc -l | tr -d '[:space:]')"
echo -e  "${BPurple}Total books: ${BGreen}$total_files, ${BYellow}added " ${BGreen}$files_added, "${BRed}read/modified" ${BGreen}$files_modified${NC}, "deleted " $files_deleted,  "renamed" $files_renamed

# Save stats as new line with date to local csv
echo ${YESTERDAY}, ${CURRENTDATETIME}, $total_files, $files_added, $files_modified, $files_deleted, $files_renamed >> $DATA_FILE

# build library tree in the README.md file
python3 build.py

git add .
# Commit Changes to Git with Custom Message
commit_msg=("$YESTERDAY Daily Reading Stats: Books Added: $files_added, Book read: $files_modified")
echo "Commit message"
echo $commit_msg
git commit -m "$commit_msg"
git push


