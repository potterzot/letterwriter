#!/bin/bash
#script to generate a blank rmarkdown letter

DATE1=`date +%Y-%m-%d`
DATE2="`date +%B` `date +%d`, `date +%Y`"

# Command line options
SHORT=hlt:n:c:s:z:
LONG=help,list,title:,name:,address1:,address2:,city:,state:,zip:

PARSED=$(getopt --options $SHORT --longoptions $LONG --name "$0" -- "$@")

if [[ $? -ne 0 ]]; then
    # e.g. $? == 1
    #  then getopt has complained about wrong arguments to stdout
    exit 2
fi

# use eval with "$PARSED" to properly handle the quoting
eval set -- "$PARSED"

#options
while true; do
  case "$1" in
    -h|--help)
      echo "
        USAGE: gen_letter <names>
          -h --help: print this message
          -l --list: list names
          -t --title: addressee title
          -n --name: addressee name
             --address1: addressee address line 1
             --address2: addressee address line 2
          -c --city: addressee city
          -s --state: addressee state
          -z --zip: addressee zip

"
      exit 2
      ;;
    -l|--list)
      cat replist.csv | cut -d ',' -f2
      exit 2
      ;;
    -t|--title)
      title="$2"
      shift 2
      ;;
    -n|--name)
      name="$2"
      shift 2
      ;;
    --address1)
      address1="$2"
      shift 2
      ;;
    --address2)
      address2="$2"
      shift 2
      ;;
    -c|--city)
      city="$2"
      shift 2
      ;;
    -s|--state)
      state="$2"
      shift 2
      ;;
    -z|--zip)
      zip="$2"
      shift 2
      ;;
    --)
      shift
      break
      ;;
    *)
      echo "
        Invalid option. Please use -h or --help for help."
      echo ''
      exit 3
  esac
done

#only handle one name at a time
if [[ $# -ne 0 ]]; then
    echo "$0: $1"
      echo ''
    exit 4
fi

#actual part of the script
fname=${DATE1}_${name// /_}.Rmd
cp letters/blank_letter.Rmd letters/${fname}
if [[ $DATE2 ]];     then sed -i -e "s/<DATE>/${DATE2}/g" letters/${fname}; fi
if [[ $title ]];     then sed -i -e "s/<TITLE>/${title}/g" letters/${fname}; fi
if [[ $name ]];      then sed -i -e "s/<NAME>/${name}/g" letters/${fname}; fi
if [[ $address1 ]];  then sed -i -e "s/<ADDRESS1>/${address1}/g" letters/${fname}; fi
if [[ $address2 ]];  then sed -i -e "s/<ADDRESS2>/${address2}/g" letters/${fname}; fi
if [[ $city ]];      then sed -i -e "s/<CITY>/${city}/g" letters/${fname}; fi
if [[ $state ]];     then sed -i -e "s/<STATE>/${state}/g" letters/${fname}; fi
if [[ $zip ]];       then sed -i -e "s/<ZIP>/${zip}/g" letters/${fname}; fi
echo "Letter to ${name} has been drafted!"


