## awk string manipulation example
```bash
# this will be our input file/string:
02 May 2021 - 04:02:00 | PROFIT, sold 19.4205891078 AUDIOUSDT for 2.605 dollar per unit. Money left 100.6 dollar

cat fileabove.txt | awk '{$9=substr($9,0,7); print($1,$2,$3,$4,$5,$8,$9,$10)}'

# the first part (optional), $9=substr($9,0,7) , takes the 9th item (separated by spaces) and shortens it to a max length of 6 characters. more of there expressions can be added, separated by ;

# the second part, print($1,$2,$3,$4,$5,$8,$9,$10), decides which parts to print and will take the $9 we edited

#result:
02 May 2021 - 04:02:00 sold 19.420 AUDIOUSDT
#$1 $2  $3  $4   $5     $8    $9     $10
```

## awk specified line display example
```bash
# this will be our input file/string:
test1
test2
test3
test4
test5

#command, $0 is important to also print the actual value, not just the line number
cat fileabove.txt | awk 'NR==2, NR==4 {print NR, $0}' 

#this only prints the lines between those 2 numbers
#result:
2 test2
3 test3
4 test4
```

## awk 'grep'-like example
```bash
# this will be our input file/string:
manager account 45000
clerk account 25000

#command
cat fileabove.txt | awk '/manager/ {print}' 

#this acts like a grep command, only plrinting lines containing the string 
#result:
manager account 45000
```

## short but useful
```bash
# find longest line in the file
awk '{ if (length($0) > max) max = length($0) } END { print max }'

# count lines in a file
awk 'END { print NR }'

# printing lines with more than 10 characters
awk 'length($0) > 10'

# check for a string in a specific column (separated by spaces)
awk '{ if($3 == "teststring") print $0;}'
