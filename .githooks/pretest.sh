#!/bin/sh

usage(){
  echo "$0 [branch] [config file]"
  echo "$? = 0: test success, 1: test failure"
}


if test $# -ne 2; then
  usage;
  exit 1
fi

branch=`echo "$1" | sed 's/^ *\| *$//'`
configfile=`echo "$2" | sed 's/^ *\| *$//'`

is_target=0

working_section=""

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
    case "$branch" in
      $section)
                working_section=$section
                is_target=1
                ;;
      *)
        is_target=0
        ;;
    esac
  elif test $is_target -ne 0; then
    eval $line > /dev/null
    code=$?
    if test $code -ne 0; then
      echo "TEST FAIL: section=[\"$working_section\"] code=[\"${line}\"]"
      exit $code
    fi
  fi

done < $configfile

exit 0
