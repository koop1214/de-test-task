#!/bin/bash

# script.sh - реализует простейшее key-value хранилище

##### Constants

FILENAME=storage.txt

##### Functions

usage()
{
    echo "usage: script [-s key value] | [-g key] | [-d key] | [-h]"
}

set_value()
{
    key=$1
    value=$2

    echo "$key, $value" >> $FILENAME
}

del_value()
{
    key=$1
    value="#tombstone#"

    echo "$key, $value" >> $FILENAME
}

get_value()
{
    key=$1
    value="NULL"

    while IFS= read -r line
    do
      arrIN=(${line//, / })

     if [ ${arrIN[0]} == $key ]
     then
         value=${arrIN[1]}
         break
     fi
    done <<< $(tac $FILENAME)
    #done < "$FILENAME"

     if [ $value == "#tombstone#" ]
     then
         value="NULL"
     fi

    echo "value - $value"
}


##### Main
if [ "$#" -lt 1 ]; then
    usage
    exit
fi

key=
value=

case $1 in
    -s | --set )            shift
                            key=$1
                            shift
                            value=$1
                            set_value "$key" "$value"
                            ;;
    -g | --get )            shift
                            key=$1
                            get_value "$key"
                            ;;
    -d | --del )            shift
                            key=$1
                            del_value "$key"
                            ;;
    -h | --help )           usage
                            exit
                            ;;
    * )                     usage
esac