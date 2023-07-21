#!/bin/bash

### PART 1 ###

if [ "$#" != 2 ]; then
  echo "Usage: lab.sh <input file> <output file>" #This is our usage message
  exit 1
fi

inp="$1"
outp="$2"

echo "Input File : $inp"
echo "Output File : $outp"

### PART 2 ###

if test -f $inp; then  
echo "Yay!, Input file named $inp exists"
else
echo "Gomen!, no such input file named $inp"
fi  

### PART 3 ###

echo "***************** Concise Data *****************"  > "$outp" 
# Single > instead of >> ensures any file with name $outp will be overwritten
# Subsequent use of >> ensures anything is "appended" to $outp and not overwritten

echo "" >> "$outp"

awk 'BEGIN {FS=","; OFS=" "} {print $1, $2, $3, $5, $6, $7, $10, $11}' "$inp" >> "$outp"

### PART 4 ###

echo "" >> "$outp"
echo "***************** Following are the college with HighestDegree as Bachelor's *****************"  >> "$outp"
echo "" >> "$outp"

awk -F',' '
BEGIN { bach = 0 }
{
    if($3 == "Bachelor'"'"'s")
{
  print $1
  bach = bach + 1
}
}

END {
  print "Count: " bach
}
' "$inp" >> "$outp"

### PART 5 ###

echo "" >> "$outp"
echo "***************** Geography : Average Admission Rate *****************"  >> "$outp"
echo "" >> "$outp"

awk -F',' 'NR>1 {sum[$6]+=$7; count[$6]++} END {for (area in sum) print area ": " sum[area]/count[area]}' "$inp" >> "$outp"

### PART 6 ###

echo "" >> "$outp"
echo "***************** Top 5 Colleges according to MedianEarnings *****************"  >> "$outp"
echo "" >> "$outp"

awk -F ',' '
BEGIN {
}

{
    earnings[NR] = $16
    name[NR] = $1
}

END {
    n = length(name)

    for (i = 1; i < n; i++) {
        for (j = 1; j < n - i; j++) {
            if ((earnings[j] - 0) < (earnings[j+1] - 0))
            {
                swap(earnings, j, j+1)
                swap(name, j, j+1)
            }
        }
    }

    for (i = 1; i <= 5; i++) {
        print name[i] ": " earnings[i] >> "'"$outp"'"
    }
}

function swap(arr, i, j) {
    temp = arr[i]
    arr[i] = arr[j]
    arr[j] = temp
}' "$inp" >> "$outp"


## Debugging Stuff
                # print earnings[j] " < " earnings[j+1]
                # print "so moved " earnings[j] " to " j+1

        # print "After one"
        #     for (i = 1; i <= 6; i++) {
        # print name[i] ": " earnings[i] >> "'"$outp"'"


## Special note :

# I did 'earnings[j] - 0' to convert it into numerical
# Earlier, the top two colleges which had their MedEarnings > 100000 were shown at the bottom of list
# instead of being top two because the comparison was being lexicographic!!

### DONE ###

echo "Stuff done and exported to $outp!"
echo "Sayonara!"

