## simple grep example
```bash
# grep [OPTIONS] PATTERN [FILE...]

# take these lines as input :
Bought 19.420 AUDIOUSDT with 50.0 dollar for 2.5746 dollar per unit.
sold 19.420492503689893 AUDIOUSDT for 2.6054 dollar per unit. Money left 100.6 dollar

 #-i to ignore case since Money has a capital M
grep -i "money" fileabove.txt
# OR use piping
cat fileabove.txt | grep -i "money"

# this is the output :
sold 19.420492503689893 AUDIOUSDT for 2.6054 dollar per unit. Money left 100.6 dollar
```

## useful grep options
```bash
# invert matching selection, select all lines that do NOT match
-v, --invert-match

# Ignore case
-i, --ignore-case

# print count of number of lines that matched 
-c 

# instead of printing the output, print the filenames that contain matches
-l

# reverse of above statement, print filenames without matches
-L

# add line numbers to output
-n

# color the matching part of the lines
--color
```
