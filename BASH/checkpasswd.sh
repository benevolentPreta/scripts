#!/bin/bash - 
#
# checkpass.sh
#
# Discription:
# Check a password against the Have I Been Pwned? Database
#
# Usage:
# ./checkpass.sh PASSWORD
# or
# ./checkpass.sh
# and you will be prompted to enter password
# or
# ./checkpass.sh --file FILENAME
# to read passwords from a file, one per line
# line numbers, not passwords are echoed
#
if (( "$#" == 0 ))
  then
  printf 'Enter your password: '
  read -s PASSIN
  echo
elif [ "$1" == "--file" ]
  then
    if [ ! -z "$2" ]
      then
      COUNT=0
      while read LINE; do COUNT=$(( $COUNT + 1 )) && \
        printf 'Line: %d ' "$COUNT" && \
        ./checkpass.sh "$LINE"; done < "$2"
    else
      printf 'A file name must be specified.\nUseage: ./checkpass.sh --file FILENAME\n'
      exit 1
    fi
else
  PASSIN="$1"
fi

PASSIN=$(echo -n "$PASSIN" | sha1sum)
PASSIN=${PASSIN:0:40}

FIRSTFIVE=${PASSIN:0:5}
ENDING=${PASSIN:6}

PWNED=$(curl -s "https://api.pwnedpasswords.com/range/$FIRSTFIVE" | \
        tr -d '\r' | grep -i "$ENDING" )
PASSWDFOUND=${PWNED##*:}

if [ ! -z "$2" ] 
  then
  printf 'File list complete.\n'
elif [ "$PASSWDFOUND" ==  "" ]
  then
    printf 'Password is not in the Database.\n'  
    exit 1
  else
    printf 'Password is Pwned %d Times!\n' "$PASSWDFOUND"
    exit 0
fi
