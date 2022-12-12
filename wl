#!/bin/bash

shopt -s expand_aliases
source ~/.bash_aliases

if [ $# -lt 3 ]
then
    echo "Too few parameters. Usage:"
    echo basename "$0" \<logfile name\> \<command with parameters to execute\>
fi

rotate()
{
        caller_name="$1"
        path="$2"
        if [ ! -z $path ]; then
                path="$2/"
        fi
        dat=`date -Iseconds`
        mv $path$caller_name.log $path$caller_name.$dat.log 2>/dev/null #can be error if there is no such file
        echo "$path$caller_name.log"
}

LOG=`rotate $1`
dat=`date -Iseconds`
echo $dat > $LOG
echo "${@:2}" >> $LOG
CMD=${BASH_ALIASES[$2]}
#echo "CMD is $CMD"
if [ -z "$CMD" ]
then
    CMD=$2
fi

FULLCMD="$CMD ${@:3} 2>&1 | tee -a $LOG"
TMPEXE=`mktemp`
echo "$FULLCMD"
echo "#!/bin/bash" > $TMPEXE
echo "$FULLCMD" >>  $TMPEXE
chmod +x $TMPEXE
echo "================================"
#$FULLCMD
$TMPEXE
rm $TMPEXE
