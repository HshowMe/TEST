#!/bin/bash
file=
f=
groupname=

for arg in "$@"
do
    if [[ -n $f ]]
    then
        file=$arg
        f=
    elif [[ "${arg:0:1}" == "-" && -z $f ]]
    then
        case $arg in
        -f) f=1
            ;;
        *) echo "$arg is invalid option" >&2
            exit 2
            ;;
        esac
    else
    groupname=$arg
    fi
done

if [[ -z $groupname ]]
then
    if [[ ! -f $file ]]
    then
        groupname=$file
        file="/etc/group"
    else
    echo "there is no group name given " >&2
    exit 2
    fi
fi
if [[ `egrep -i "^$groupname:" /etc/group` ]]
then
    :
else
    echo "group does not exist!!"
    exit 1
fi 

if [[ $file && $groupname ]]
then
    result=`cat $file | grep "^$groupname:"| cut -d: -f4 | tr -s "," "\n"`
    echo "$result" # >&0 
fi

