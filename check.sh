#!/bin/bash
# automatically upload files added to given directory
# by makos

# use newline as file name separator so files with spaces
# will be treated properly
OLDIFS=$IFS
IFS=$(echo -en "\n\b")

# adjust according to your setup
HOST=SSH_HOST
PORT=PORT
ULDIR=REMOTE_TARGET_DIR
LOCDIR=LOCAL_MONITORED_DIR

# do not change these
CURRENT=$LOCDIR'.db'
NEW=$LOCDIR'.dbnew'

ls $LOCDIR > $NEW

# following compares existing .db file and formats it accordingly,
# adding slashes to tricky characters via sed so bash doesn't freak out
DIFF=$(diff $CURRENT $NEW | grep \> |
    sed "s/> //;s/(/\(/g; s/)/\)/g; s/'['/'\['/g; s/']'/'\]'/g; s/-/\-/g")

for file in $DIFF; do
    scp -P $PORT -q $LOCDIR$file $HOST:$ULDIR$file2
# if scp exits with 0 (success), delete the file that was uploaded
    if [ $? == 0 ]; then
        rm $LOCDIR$file
    fi
done

# restore the old IFS
IFS=$OLDIFS

# if last scp action exits with an error, then also quit with an error code
# and don't save the file tree into $CURRENT
if [ $? == 1 ]; then
    rm $NEW
    exit 1
else
    ls $LOCDIR > $CURRENT
    rm $NEW
fi

exit
