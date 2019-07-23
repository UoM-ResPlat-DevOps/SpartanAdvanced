-- *Slide* --
### Part 0: Goals for today
* Part 1: Advanced Linux Commands.
* Part 2: Regular Expressions.
* Part 3: Shells In General, Bash in Particular.
* Part 4: Variables, Loops, Conditionals, and Functions.
* Part 5: Shell Scripts with Slurm.
-- *Slide End* --

-- *Slide* --
### Part 0: Slide Repository
* Terminal projection via https://shellshare.net/r/Spartan
* A copy of the slides and same code is available at: `https://github.com/UoM-ResPlat-DevOps/SpartanAdvanced`
-- *Slide End* --

-- *Slide* --
### Part 1:  Archiving and Compressing Files
* Copy the file from `/usr/local/common/HPCshells/class.tar.gz` to the home directory.
* The double-barelled suffix, .tar.gz indicates that it is an archive ("tape archive"!) and compressed (with the gzip application). Such a file (often appearing as *.tgz) is often referred to as a "tarball".
* The type of a file can often be determined by the file command: `file class.tar.gz`
-- *Slide End* --

-- *Slide* --
### Part 1: Archiving and Compressing Files cont...
* To review the contents of a tarball (check for tarbombs!): `tar tf class.tar.gz`
* To recover from a tarbomb: `tar tf tarbomb.tar | xargs rm -rf`
* To extract (and compare value of compression): `tar xvf class.tar.gz`
* To create a tarball: `tar cvfz name.tar.gz directory/`
-- *Slide End* --

-- *Slide* --
<img src="https://imgs.xkcd.com/comics/tar.png" />
-- *Slide End* --

-- *Slide* --
### Part 1: Archiving and Compressing Files cont ...
* Another common compression algorithm that Linux users are likely to encounter with regularity is bzip2.
* Efficient in size, slower in decompression speed.
* To create a bzip2 tarball: `tar cvfj class.tar.bz2 class/`
* To check the contents: `tar tjf class.tar.gz` 
* To extract and uncompress the tarball : `tar xvf class.tar.bz2`
-- *Slide End* --

-- *Slide* --
### Part 1: Archiving and Compressing Files cont ...
* But wait, there's more! A third common compression is LZMA2 which is used in xz files.
* Like bzip2 efficient in size, slower in decompression speed.
* To create a xz tarball: `tar cvfJ class.tar.xz class/`
* To check the contents: `tar tf class.tar.xz` 
* To extract and uncompress the tarball : `tar xvf class.tar.xz`
-- *Slide End* --

-- *Slide* --
### Part 1: Redirections and Tee
* A core principle of UNIX-like operating systems is that the output of one program should be usable as the input to another.
* The introductory lesson included basic commands for redirection, concatenation, and piping.
* Process streams as well as data streams can be redirected: `diff <(ssh user@spartan.hpc.unimelb.edu.au ls -R /home/lev/data) <(ls -R /home/lev/workdata)`
* The default behaviour is to accept inputs from the terminal (standard input) and display the results, either output or errors, to the terminal (standard output). 
-- *Slide End* --

-- *Slide* --
### Part 1: Redirections and Tee cont..
* Redirections can be further modified by placing a number next immediately before the redirector, which affects which stream is being used for redirection. These numbers are 0 for standard input, 1 for standard output and 2 for standard error. e.g., `ls -d /home/username/seismic 2> error.txt`
* Standard error can also to be redirected to the same destination that standard output is directed to using 2>&1; it merges stderr (2) into stdout (1).
-- *Slide End* --

-- *Slide* --
### Part 1: Redirections and Tee cont..
* The tee command copies standard input to standard output and also to any files included in the tee. When combined with pipes it takes input from a single direction and outputs it two directions. e.g.,  `who -u | tee whofile.txt | grep username`
-- *Slide End* --

-- *Slide* --
### Part 1: Redirections and Tee Summary
| Redirection Syntax                | Explanation                                                    |
|:----------------------------------|:--------------------------------------------------------------:|
|`command > file`                   | Redirect standard output to a file                             |
|`command >> file`                  | Redirect standard output to end of file                        |
|`command 2> file`                  | Redirect standard error to a file                              |
|`command > file 2>&1`              | Redirect standard output and standard error to file            |
-- *Slide End* --

-- *Slide* --
### Part 1: Redirections and Tee Summary cont..
| Redirection Syntax                | Explanation                                                    |
|:----------------------------------|:--------------------------------------------------------------:|
|`command -options < file`          | Redirect a file as standard input to a command                 |
|`command >> file 2>&1`             | Redirect standard and standard error to end of file            |
| <code>command &#124; command2</code>  | Pipe standard output to a second command                   |
-- *Slide End* --

-- *Slide* --
### Part 1: Redirections and Tee Summary cont..
| Redirection Syntax                | Explanation                                                    |
|:----------------------------------|:--------------------------------------------------------------:|
|<code>command 2>&1 &#124; command2</code>  | Pipe standard output and standard error to a second command    |
|<code>command1 &#124; tee file &#124; command2</code> | Apply command1 and command2 to file        |
-- *Slide End* --

-- *Slide* --
### Part 1: File Attributes, Types, Ownership
* The `ls -l` command illustrates file ownership (user, group), file type, permissions, and date when last modified.
* The first character is type; a "-" for a regular file, a "d" for a directory, and "l" for a symbolic link. Less common file types include "b" for block devices (e.g., hard drives, ram etc), "c" for character devices which stream data one character at a time (e.g., mice, keyboards, virtual terminals).
* In UNIX-like operating systems devices are a type of file as well, and are structured under the `/dev` directory. 
-- *Slide End* --

-- *Slide* --
### Part 1: File Attributes, Types, Ownership
*  Permissions are expressed in a block of three for "user, group, others" and for permission type (read r, write w, execute x). Executable also implies 'searching', thus "x" is usually found for directories as well.
* An "s" in the execute field indicated setuid. Causes any user or process to have access to system resources as though they are the owner of the file. If the bit is set for the group, the set group ID bit is set and the user running the program is given access based on access permission for the group the file belongs to.
-- *Slide End* --

-- *Slide* --
### Part 1: File Attributes, Types, Ownership cont
* There is "t", "save text attribute", or more commonly known as "sticky bit" in the execute field allows a user to delete or modify only those files in the directory that they own or have write permission for. A typical example is the /tmp directory, which is world-writeable.
* The change permissions of a file use the `chmod` command. To chmod a file you have to own it. The command is : chmod [option] [symbolic | octal] file. For options, the most common is `-R` or `--recursive` which changes files and directories recursively.
-- *Slide End* --

-- *Slide* --
### Part 1: File Attributes, Types, Ownership cont
* For symbolic notation, first establish the user reference, either "u" (user, the owner of the file), "g" (group, members of the file's group), "o" (others, neither the owner or group members), or "a" (all). If a user reference is not specified the operator and mode applies to all.
* Then determine the operation; either "+" (add the mode), "-" remove the mode, or "=" (equals, mode only equals that expression). Finally, specify the mode permissions as described above, "r" (read), "w" (write), "x" (execute), "s" (setuid, setgid), "t" (sticky). 
-- *Slide End* --

-- *Slide* --
### Part 1: File Attributes, Types, Ownership cont
* In octal notation a three or four digit base-8 value is presented derived from the sum of the component bits, so the equivalent of "r" in symbolic notation adds 4 in octal notation (binary 100), "w" in symbolic notation adds 2 in octal notation (binary 010) and "x" adds 1 in octal notation (binary 001). No permissions adds 0 (binary 000). For special modes the first octal digit is either set to 4 (setuid), 2 (setgid), or 1 (sticky). The sum of the three (or four components) thus makes up an alternative exact notation for the chmod command.
-- *Slide End* --

-- *Slide* --
<img src="https://raw.githubusercontent.com/UoM-ResPlat-DevOps/SpartanAdvanced/master/Images/jamesbond007.jpg" />
-- *Slide End* --

-- *Slide* --
### Part 1: File Attributes, Types, Ownership cont
* If you have root permission, you can make use of the `chown` (change owner) command. Usually group is optional on the grounds that users are usually provided ownership. A common use is to provide ownership to web-writeable directories e.g., (`chown -R www-data:www-data /var/www/files`). 
-- *Slide End* --

-- *Slide* --
### Part 1: File Attributes, Types, Ownership cont
* A `umask` ("user mask") which we encountered in the .bashrc limiting the permission modes for files and directories created by a process. When a program or script creates a file or directory, it specifies  permissions. Typical umask values are 022 (removing the write permission for the group and others) and 002 (removing the write permission for others).
-- *Slide End* --

-- *Slide* --
### Part 1: Links and File Content
* The ln command creates a link, associating one file with another. There are two basic types; a hard link (the default) and a symbolic link. 
* The core difference is that a hard link is a specific location of physical data, whereas a symbolic link is an abstract location of another file. Hard links cannot link directories and nor can they cross system boundaries; symbolic links can do both of these. 
* The general syntax for links is: `ln [option] source destination` .This most common option is `-s`, to create a symbolic link. The source is the original file. The destination is the link.
-- *Slide End* --

-- *Slide* --
### Part 1: Links and File Content cont...
* With a hard link: File1 -> Data1 and File2 -> Data1 . With a symbolic link: File2 -> File1 -> Data1
* A file consists of a filename and an inode reference. The reference maps to the actual inode. The inode contains the permissions, and data address. More than one filename can have the same inode reference
* Links are particularly useful if you want to share a file with another user, such as working on a collaborative paper (ensure that read/write access is granted). 
-- *Slide End* --

-- *Slide* --
### Part 1: File Manipulation Commands
* The command head and tail print the first and last ten lines of a file by default. The standard syntax is `[head..tail] [option] [file]`. The most typical option is `-n` for the number of lines. 
* Rename will rename the specified files by replacing the first occurrence of expression in their name by replacement. e.g., `rename .txt .bak *.txt`
-- *Slide End* --

-- *Slide* --
### Part 1: File Manipulation Commands cont...
* Split can be used to split large files into smaller components. The general syntax is `split [OPTION]... [INPUT [PREFIX]]`. Common options include byte (-b #) or linecount (-l #, default of 1000) for the new files. The input is the filename and the prefix is the output, PREFIXaa, PREFIXab etc.
-- *Slide End* --

-- *Slide* --
### Part 1: File Manipulation Commands cont...
* Sort will organise a text file into an order specified by options and output to a specific file, if desired. The general syntax is `sort [option] [input file] -o [filename]`. Some of the options include -b (ignore beginning spaces), -d (use dictionary order, ignore punctuation), -g (general, natural language), -m (merge two input files into one sorted output, -r (sort in reverse order) and -V (version number order).
* To filter repeated lines in a text file use uniq. The standard syntax is `uniq [options] [input file] [output file]`. 
-- *Slide End* --

-- *Slide* --
### Part 1: System Information Commands
* The du "disk usage' command has the standard syntax of `du [options] [file]`. Without any arguments du will print all files, entering directories recursively, and provide output in kilobytes. Most commonly experessed as `du -sh` (disk usage, summary form, human readable)
*  The following is a handy use of xargs is to parse a directory list and output the results to a file. The command script below runs a disk usage in summary, sorts in order of size and exports to the file diskuse.txt. The "\n" is to ignore spaces in filenames.
`du -sk * | sort -nr | cut -f2 | xargs -d "\n" du -sh  > diskuse.txt`
-- *Slide End* --

-- *Slide* -- 
### Part 1: System Information Commands cont...
* The command 'df' will generate a report of file system disk space usage.
* The command `free -h` provides total, used, and free memory on a system.
* A typical command to access system information is `uname`, with the simple syntax `uname [options]`. The most common command is uname -a (all) which provides, in order, kernel name, network node name, kernel release and version, machine hardware name, processor and hardware platform (if known), and operating system. 
-- *Slide End* --

-- *Slide* --
### Part 1: System Information Commands cont...
* Another useful source for system information is the /proc directory. The directory doesn't actually contain 'real' files but runtime system information. Examples: `less /proc/cpuinfo`, `less /proc/filesystems`, `less /proc/uptime`,
`less /proc/loadavg`, `less /proc/meminfo`, `less /proc/mounts`, `less /proc/partitions`
* The command lscpu will provide information about the processor architecture as well gathered from /proc/cpuinfo including the number of CPUs, threads, cores, and sockets. 
-- *Slide End* --

-- *Slide* --
### Part 2: Regular Expressions and Metacharacters
* The main text searching, substitution, and reporting tools are grep, sed (stream editor), and awk (programming language) respectively.
* Regular expressions have meta-characters, some of which are described below.

| Metacharacter | Explanation         | Example                                          |
|:--------------|:-------------------|:-----------------------------------------------|
| ^             | Beginning of line anchor   | `grep '^row' /usr/share/dict/words`       |
| $             | End of line anchor         | `grep 'row$' /usr/share/dict/words`       |
-- *Slide End* --

-- *Slide* --
### Part 2: Regular Expressions and Metacharacters cont..
| Metacharacter | Explanation        | Example   |
|---------------|--------------------|-----------|
| .             | Any single character       | `grep '^...row...$' /usr/share/dict/words` |
| *             | Match zero plus preceding characters | `grep '^...row.*' /usr/share/dict/words`   |
| [ ]           | Matches one in the set                 | `grep '^[Pp].row..$' /usr/share/dict/words`    |
-- *Slide End* --

-- *Slide* --
### Part 2: Regular Expressions and Metacharacters cont..
| Metacharacter | Explanation        | Example   |
|---------------|--------------------|-----------|
| [x-y]		| Matches on in the range                | `grep '^[s-u].row..$' /usr/share/dict/words`   |
| [^ ]          | Matches one character not in the set   |  `grep '^[^a].row..$' /usr/share/dict/words`   |
| `|`     | Logical OR   |  `grep '^[^a|P].row..$' /usr/share/dict/words`   |
-- *Slide End* --

-- *Slide* --
### Part 2: Regular Expressions and Metacharacters cont..
| Metacharacter | Explanation        | Example   |
|---------------|--------------------|-----------|
| [^x-y]        | Matches any character not in the range | `grep '^[^a-z].row..$' /usr/share/dict/words` |
| \             | Escape a metacharacter |  `grep '^A\.$' /usr/share/dict/words`
-- *Slide End* --

-- *Slide* --
### Part 2: Regular Expressions and Metacharacters cont...
* The 'matches one in the set' metacharacter has a number of options that one may find useful.

| Metacharacter| Explanation                                             |
|--------------|---------------------------------------------------------|
| [:digit:]    | Only the digits 0 to 9                                  |
| [:alnum:]    | Any alphanumeric character 0 to 9 OR A to Z or a to z.  | 
| [:alpha:]    | Any alpha character A to Z or a to z.                   |
| [:blank:]    | Space and TAB characters only.                          |
-- *Slide End* --

-- *Slide* --
### Part 2: Regular Expressions and Metacharacters cont...
* Metacharacters can be combined in an interesting manner with grep options. Examples; (i) using grep to count the number of empty lines in a file; `grep -c '^$' filename` (ii) a search for words with no vowels; `grep -v "[aeiou]" /usr/share/dict/words`
-- *Slide End* --

-- *Slide* --
<img src="https://imgs.xkcd.com/comics/regular_expressions.png" />
-- *Slide End* --

-- *Slide* --
### Part 2:  Text Manipulation with sed
* Sed makes text transformation on an input stream (e.g., file) and has the general form of `sed [OPTION] [SCRIPT] [INPUT]`. Some common options are `e` (multiple scripts per command), `-f` (add script file) and `-i` (in-place editing).
* The general form of a script is `Command/RegExp/Replacement/Flags`. The most common command is `s` for `substitute`, and the most common flags are `g` (global) or a number for replacement thoughout each line and `I` to ignore case. 
* Sed has alternative three alternative delimiters in its scripts; '/', ':', or '|'
-- *Slide End* --

-- *Slide* --
### Part 2: Text Manipulation with sed cont...
| Command                | Explanation                                                              |
|------------------------|:-------------------------------------------------------------------------|
| `sed 's/^/     /'`       | Insert five whitespaces at the beginning of every line.                  | 
| `sed '/baz/s/foo/bar/g'` |  Substitute all instances of 'foo' with 'bar' on lines that start with 'baz' |
| `sed '/baz/!s/foo/bar/g'`| Substitute "foo" with "bar" except for lines which contain "baz" |
| `sed /^$/d`    | Delete all blank lines.                                                    |
| `sed s/ *$//` | Delete all spaces at the end of every line.             |
-- *Slide End* --

-- *Slide* --
###  Part 2: Text Manipulation with sed cont...
| Command               | Explanation                             |
|-----------------------|----------------------------------------|
| `sed -i 's/$/\r/g'`     | *nix to MS-Windows, adds CR.            | 
| `sed -i 's/\r$//g'`     | MS-Windows to *nix, removes CR          |

* A popular list of one-line sed commands can be found at the following URL 
http://sed.sourceforge.net/sed1line.txt
-- *Slide End* --

-- *Slide* --
###  Part 2: Report Presentation with awk
* Awk is a data driven programming language, its name derived from the surname initial of the designers (Alfred Aho, Peter Weinberger, and Brian Kernighan). Awk is particularly good at understanding and manipulating text structured by fields - such as tables of rows and columns. 
* The essential organization of an AWK program follows the form: pattern { action }. This is sometimes structured with BEGIN and END which specify actions to be taken before any lines are read, and after the last line is read. With it's structured data features, awk can print columns by number ($0 equals everything).
-- *Slide End* --

-- *Slide* --
### Part 2: Report Presentation with awk
* By default awk uses a space as the internal field separator. To use a comma invoke with `-F` e.g. `awk -F"," '{print $3}' quakes.csv`
* Adding new separators to the standard output print of multiple fields is recommended - otherwise AWK will print without any separators. For example; `awk -F"," '{print $1 " : " $3}' quakes.csv`
* Other commands can be piped through awk: `awk -F"," '{print $1 " : " $3 | "sort"}' quakes.csv | less`
-- *Slide End* --

-- *Slide* --
### Part 2: Report Presentation with awk cont...
* 'NR' specified the row number. More examples:
`awk -F"," 'END {print NR}' quakes.csv`    
`awk -F"," 'NR>1{print $3 "," $2 "," $1}' quakes.csv`   
`awk -F"," '(NR <2) || (NR!=6) && (NR<9)' quakes.csv > selection.txt`   
-- *Slide End* --

-- *Slide* --
### Part 2: Report Presentation with awk cont...
* Other useful awk one-liners make use of the arithmetic functions of this programming language:
* Print the total number of fields in $file.    
`awk '{totalf = totalf + NF }; END {print totalf}' $file`
* Print the sum of the fields (columns) of every line (row); NF is number of field.    
`awk '{sum=0; for (i=1; i<=NF; i++) sum=sum+$i; print sum}' $file`	
* A popular list of one-line awk commands can be found at the following URL   
`http://www.pement.org/awk/awk1line.txt`
-- *Slide End* --

-- *Slide* --
### Part 3: Shells and Login Files
* The default shell environment is the Bash shell (Bourne-again shell). The shell is a program that acts as command interpreter between the user and the kernel.
* When Bash is invoked as an interactive login shell it first reads and executes commands from the file `/etc/profile`. It looks for `~/.bash_profile`, `~/.bash_login`, and `~/.profile`, in that order, and reads and executes commands from the first one that exists and is readable.
-- *Slide End* --

-- *Slide* --
### Part 3: Shells and Login Files cont...
* Users can modify their `.bash_profile` to ensure that they have the environmental features that they want when they login.
* When a command is entered it is stored in `.bash_history`
* When a login shell exits, Bash reads and executes commands from the file `~/.bash_logout`, if it exists. 
-- *Slide End* --

-- *Slide* --
### Part 3: Example extended .bash_profile
* A sample extended `.bash_profile` is available from the directory `/usr/local/common/HPCshells`
* Includes alias, history size modifications etc.
-- *Slide End* --

-- *Slide* --
### Part 3: Various Shells
* Examples of various shells include the *nix-universal Bourne shell (sh) Bourne-Again shell (bash), Z shell (zsh), Korn shell (ksh), extended C shell (tcsh) and the friendly interactive shell (fish). There is even an amusing attempt to develop a shell into a text-based adventure game (Adventure shell, available at `http://nadvsh.sourceforge.net/`).
* To view what shells are available; `ls -l /bin/*sh*`
-- *Slide End* --

-- *Slide* --
### Part 3: Various Shells cont...
* Each have different features and often slightly different syntax, which is mostly beyond the scope of this course. However among bash and tsch the following are two major differences.

| Value       |    bash          |    tcsh             |
|-------------|------------------|--------------------|
|Variable     |  `var=val`       |  `set var=val`        |
|Environment  |  `export var=val`  |  `setenv var val`     | 
-- *Slide End* --

-- *Slide* --
### Part 3: Bash Shell Shortcuts
| Value       | Explanation                                                                     |
|-------------|:--------------------------------------------------------------------------------|
| ~           | Shortcut to user's home directory.                                              | 
| .           | The current directory.                                                          | 
| ..          | One level up in the file system hierarchy.                                      | 
| TAB         | Autocompletion suggestions.                                                     | 
| !!          | Repeat last typed command; can be combined with other commands.                 | 
| !ec	      | Repeat last typed command that started with 'ec'                                |
| &&          | Combine commands if the first succeeds (e.g., make && make install)                     | 
| &#124;&#124; | Alternative command if the first fails (e.g., make makefile1 &#124;&#124; make Makefile)  | 
-- *Slide End* --

-- *Slide* --
### Part 3: Bash Shell Shortcuts cont...
| Value       | Explanation                                                                     |
|-------------|:--------------------------------------------------------------------------------|
| ctrl+w      | Remove word behind cursor.                                                      | 
| ctrl+u      | Delete everything from cursor to beginning of the line                          | 
| alt+f       | Go forward to the end of the previous word                                      | 
| alt+b       | Move cursor back to the beginning of the previous word                          | 
| ctrl+d      | Quick logout.                                                                   | 
| ctrl+r      | Recursive search through your history to locate previous commands.              | 
| ctrl+z      | Stop the current process.                                                       |
-- *Slide End* --

-- *Slide* --
### Part 3: Use of Shell Scripting
* Shell scripts combine Linux commands with logical operations. It is an underrated utility, but it is not the answer for everything.
* They are not always great at resource intensive tasks (e.g., extensive file operations) where speed is important. They are certainly not recommended for heavy-duty mathematical operations (e.g., floating point) - use programming language instead. They are not recommended in situations where data structures, multi-dimensional arrays (it's not a database!) and port/socket I/O is important. 
-- *Slide End* --

-- *Slide* --
### Part 3: Scripts with Variables
*  The most basic form of scripting simply follows commands in sequence, such as this rather undeveloped backup script, which runs tar and gzip on the home directory. A version of this is available at: `/usr/local/common/HPCshells/backup1.sh`
* Not much of a script! Consider what parts can be made into variables. `/usr/local/common/HPCshells/backup2.sh`
* A variable is prefaced by a dollar sign ($) to refer to its value. 
-- *Slide End* --

-- *Slide* --
### Part 3: Special Characters
* There are also a number of special characters in bash scripting. 
* Quoting disables these characters for the content within the quotes. Both single and double quotes can be used, and single quotes can be used to incorporate double quotes. 
* "Backtick" quotation marks can be used for command substitution within the script, but they are not POSIX standard. 
* Examples: 
`echo 'The "Sedimentary" and the "Igenuous" argue about metamorphism'`   
`echo "There are $(ls | wc -l) files in $(pwd)"`
-- *Slide End* --

-- *Slide* --
### Part 3: Scripts with Loops
* In addition to variable assignments, bash scripting allows for loops (for/do, while/do, util/do). 
* The for loop executes stated commands for each value in the list.
* The while loop allows for repetitive execution of a list of commands, as long as the command controlling the while loop executes successfully.
* The until loop executes until the test condition executes successfully.
-- *Slide End* --

-- *Slide* --
### Part 3: Scripts with Loops cont...
* Examples of these scripts are in  `/usr/local/common/HPCshells/loops.txt`
* These can be converted to permanent scripts e.g., `/usr/local/common/HPCshells/lowercaserename.sh` and `/usr/local/common/HPCshells/sshtrigger.sh`
-- *Slide End* --

-- *Slide* --
<img src="https://raw.githubusercontent.com/UoM-ResPlat-DevOps/SpartanAdvanced/master/Images/whilenotedge.jpg" />
-- *Slide End* --

-- *Slide* --
### Part 3: Scripts with Conditionals
* A set of conditions can be expressed through an if/then/fi structure. A single test with an alternative set of commands is expressed if/then/else/fi. Finally, a switch-like structure can be constructed through a series of elif statements in a if/then/elif/elif/.../else/fi structure. i.e.,
1. if..then..fi statement (Simple) 
2. if..then..else..fi statement (Optional) 
3. if..elif..else..fi statement (Ladder) 
4. if..then..else..if..then..fi..fi..(Nested) 
* An example is available at: `/usr/local/common/HPCshells/filetest.sh`
-- *Slide End* --

-- *Slide* --
### Part 3: Scripts with Conditionals cont...
* There are several conditional expressions that could be used to test with the files. The following are few common examples; 

| Value                           |Explanation                                                   |
|---------------------------------|-------------------------------------------------------------|
| [ -e filepath ]                 | Returns true if file exists.                                 |
| [$var lt value ] [ gt ] [ eq ]  | Returns true if less than, greater than or equal             |
| [ -f filepath ]                 | Returns true if filepath is actually a file.                 |
| [ -x filepath ]                 | Returns true if file exists and executable.                  |
-- *Slide End* --

-- *Slide* --
### Part 3: Scripts with Conditionals cont...
| Value                           |Explanation                                                   |
|---------------------------------|-------------------------------------------------------------|
| [ -S filepath ]                 | Returns true if file exists and its a socket file.           |
| [ expr1 -a expr2 ]              | Returns true if both the expression is true.                 |
| [ expr1 -o expr2 ]              | Returns true if either of the expression1 or 2 is true.      | 
-- *Slide End* --

-- *Slide* --
### Part 3: Scripts with Conditionals cont...
* Conditionals can also be interrupted and resumed using the 'break' and 'continue' statements. The break command terminates the loop (breaks out of it), while continue causes a jump to the next iteration (repetition) of the loop, skipping all the remaining commands in that particular loop cycle. Examples at: `/usr/local/common/HPCshells/break.sh` and `/usr/local/common/HPCshells/continue.sh`
* A variant on the conditional to escape the problems associated with deeply nested if-then-else statements is the `case` statement. The first match executes the listed commands. Examples at: `/usr/local/common/HPCshells/case.sh`
-- *Slide End* --

-- *Slide* --
### Part 3: Script Selects and Functions
* The select command with conditionals can be used to create simple menus for users which prompts them for their input. There is an example at: `/usr/local/common/HPCshells/select.sh`
* Functions subroutines or subscripts within a shell script, which can have local variables, accept, and return parameters. Functions may not be empty. See the example at: `/usr/local/common/HPCshells/hellofunction.sh`
-- *Slide End* --

-- *Slide* --
### Part 3: Scripting Conventions
* There are several scripting conventions which make the code more effective, more robust, more portable, and more readable. Therefore use them!
* The following example at: `/usr/local/common/HPCshells/findemails.sh` and the datafile `/usr/local/common/HPCshells/hidden.txt` will illustrate some of these conventions.
-- *Slide End* --

-- *Slide* --
### Part 3: Scripting Conventions cont...
* Liberally comment your code so that other readers know what it does. Use explicit variable names. Use output to tell the user what is happening. Use variables when appropriate rather than hard-coded paths. Provide exit statements to clear variables and provide an error code.
* A common conditional, and sadly often forgotten, is whether or not a script has the requiste files for input and output specified!
* Invite user input with the 'read' command; protect against escape characters with the 'raw' option.
-- *Slide End* --

-- *Slide* --
### Part 3: Metacharacters
* Metacharacters have meaning beyond their literal meaning. Powerful, but use with caution (e.g., wildcards). Metacharacter meaning depends very much on the context, which can cause problems. For example;
* the semi-colon can be a command separator in a script or a double as a terminator in a case statement. 
* the colon represents a null command in a script, or as a field separator (e.g., in `/etc/passwd`).
* the dot (.) is used to source a filename, to represent the current working directory as a path, to represent a character in regular expression, or in multiple form as a sequence.
-- *Slide End* --

-- *Slide* --
### Part 3: Metacharacters cont ..
* Single quotes however will interpret anything literally between the quotes as a string with no interpretation to a meta-character (aka 'strong quoting'). Double quotes will substitute a limited set which are usually the symbols which are wanted in their interpreted mode. e.g., variables, backticks, and sometimes backslash escapes. (aka "weak quoting"). n example is given at `/usr/local/common/HPCshells/quotes.sh`
-- *Slide End* --

-- *Slide* --
### Part 3: Metacharacters cont ..
* In some cases backtics are seen for command substitution. This is not a POSIX standard, it does exist for historical reasons. Nesting commands with backticks also requires escape characters; the deeper the nesting the more escape characters required. e.g., echo "Hello, $(whoami)".
-- *Slide End* --

-- *Slide* --
### Part 3: Script Commands
* A script can also be initiated in the background with an ampersand. 
* The commands `fg` (foreground) and `bg` (background) are complementary manipulations of processes.  Jobs can be suspended with Cntrl-Z to return to the terminal. 
* A background job can be killed with `kill %job-number`. A listing of jobs can be achieved with the `jobs` command.
-- *Slide End* --

-- *Slide* --
### Part 3: Script  Commands cont...
* For example;
`eval 'for i in {1..100}; do sleep 2; echo "Igneous" >> rocks.txt ; done' &`    
`eval 'for i in {1..100}; do sleep 2; echo "Sedimentary" >> rocks.txt ; done'`    
`eval 'for i in {1..100}; do sleep 2; echo "Metamorphic" >> rocks.txt ; done' &`    
* It is important not to run large scripts on the login node. Set up a job on a compute node with `sinteractive`.
-- *Slide End* --

-- *Slide* --
### Part 4: Shell Scripting Example with PBS and Slurm
* Because SLURM calls a shell when launched any shell commands can can also be used in a Slurm script. 
* As an example, an MD Drug Docking experiment, MD3 -  Aspirin to A2 phospholipase, includes a range of Linux commands and shell script structures. This includes variable assignment, redirections, and loops. This job can be copied to a local directory and lauched like any other Slurm job. The jobscript and data files are at: `/usr/local/common/HPCshells/NAMD/drugdock.Slurm`
-- *Slide End* --

-- *Slide* --
### Part 4: Automatic Script Generation
* A heredoc (also known as a here-string or here-document) is a file or input literal, a section of source code that is treated as a separate file with specified delimiters. In various Unix shells the '<<' with a delimiter name will treat subsequent code until the identifier as reached as a separate file. With the addition of a minus sign, leading tabs are ignored which aid formatting. 
-- *Slide End* --

-- *Slide* --
### Part 4: Automatic Script Generation cont...
* For example, the command `tr a-z A-Z << END_TEXT` will conduct a translate on all data until a END_TEXT is reached in the doc for or `tr a-z A-Z <<< 'igneous sedimentary metamorphic'` in the string form. Variables can also be parsed. e.g.., `rocks='igneous sedimentary metamorphic'`, `tr a-z A-Z <<< $rocks`. 
* Heredocs can also be used however to create Slurm scripts. A loop can be used to create multiple jobs for submission. See `/usr/local/common/HPCshells/heres/herescript.sh`. See also `/usr/local/common/Gaussian`
-- *Slide End* --

-- *Slide* --
<img src="https://raw.githubusercontent.com/UoM-ResPlat-DevOps/SpartanIntro/master/Images/hypnotoad.png" width="150%" height="150%" />
-- *Slide End* --
