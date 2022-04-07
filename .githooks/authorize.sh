#!/bin/sh

usage(){
  echo "$0 [username] [branch] [config file]"
  echo "$? = 0: permission exist, 1: no permission or error"
}


if test $# -ne 3; then
  usage;
  exit 1
fi

username=`echo "$1" | sed 's/^ *\| *$//'`
branch=`echo "$2" | sed 's/^ *\| *$//'`
configfile=`echo "$3" | sed 's/^ *\| *$//'`

is_restricted=0

while read line
do

  line=`echo "$line" | sed 's/^ *\| *$//'`

	if test -z "$line"; then
		continue
	fi

	echo "$line" | grep -v '^#.*' > /dev/null
  if test $? -ne 0; then
    continue
  fi

  section=`echo "$line" | sed -n -e 's/\[\(.\+\)\]/\1/p'`
  if test -n "$section" ; then
    if test $is_restricted -ne 0; then
      exit 1
    fi
    case "$branch" in
      $section)
                is_restricted=1
                ;;
    esac
  elif test $is_restricted -ne 0; then
    case "$username" in
      $line)
            exit 0
            ;;
    esac
  fi

done < $configfile

exit $is_restricted
