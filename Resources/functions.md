# Turn Smart Commands into Functions
## Taken from Andrew Worsely. This and more at:
## https://github.com/amworsley/intro-shell-programming/blob/master/shell-programing.md

## Don't waste that knowledge and experience e.g.,

$ find . -mtime -7 -type f -print

Make a shell function instead

$ newfiles() {
   find . -mtime -7 -type f -print
}

# Build on it!
## Add an argument to make it flexible

$ newfiles() {
   find . -mtime "-${1:-7}" -type f -print
 }

## Now files less than 10 days old

$ newfiles 10

## Save it to your .bashrc, for example

cat >> ~/.bashrc  
newfiles() {
   find . -mtime "-${1:-7}" -type f -print
}  

