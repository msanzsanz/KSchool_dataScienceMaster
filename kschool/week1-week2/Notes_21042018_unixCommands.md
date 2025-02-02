# Notes taken on April 21th

## Unix commands 

**1. cat /etc/os-release, to list the linux distribution**

```bash
 dsc@master: ~ % cat /etc/os-release                                 ~ 0 9:33:53
 NAME="Ubuntu"
 VERSION="17.10 (Artful Aardvark)"
 ID=ubuntu
 ID_LIKE=debian
PRETTY_NAME="Ubuntu 17.10"
VERSION_ID="17.10"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=artful
UBUNTU_CODENAME=artful
```

**2. Tips for using the back-ticks and $ keywords**
```bash
dsc@master: ~ % echo PATH                                           ~ 0 9:52:09
PATH
dsc@master: ~ % echo "PATH"                                         ~ 0 9:52:14
PATH
dsc@master: ~ % echo "$PATH"                                        ~ 0 9:52:19
/home/dsc/anaconda3/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/bin/popcorntime:/opt/go/bin:/usr/local/spark/bin
dsc@master: ~ % echo '$PATH'                                        ~ 0 9:52:23
$PATH
dsc@master: ~ % date                                                ~ 0 9:52:31
sáb abr 21 09:52:40 CEST 2018
dsc@master: ~ % echo `date`                                         ~ 0 9:52:40
sáb abr 21 09:52:46 CEST 2018
dsc@master: ~ %                                                     ~ 0 9:52:46
dsc@master: ~ % echo `date`                                         ~ 0 9:52:40
sáb abr 21 09:52:46 CEST 2018
dsc@master: ~ % echo "$date"                                        ~ 0 9:52:46

dsc@master: ~ % echo "$(date)"                                      ~ 0 9:54:48
sáb abr 21 09:54:56 CEST 2018
dsc@master: ~ % echo "$(ls)"                                        ~ 0 9:54:56
anaconda3/
Data/
derby.log
Desktop/
Documents/
Downloads/
metastore_db/
Music/
Pictures/
Public/
R/
Repos/
Templates/
Videos/

```

**3. cd, some shortcuts**
> cd - goes to the previous folder
``` bash
dsc@master: ~ % pwd                                                ~ 0 10:00:35
/home/dsc
dsc@master: ~ % cd anaconda3/bin/                                  ~ 0 10:00:39
dsc@master: bin % pwd                                ~/anaconda3/bin 0 10:00:54
/home/dsc/anaconda3/bin
dsc@master: bin % cd -                               ~/anaconda3/bin 0 10:00:56
~
dsc@master: ~ % pwd                                                ~ 0 10:00:58
/home/dsc
dsc@master: ~ %                                                    ~ 0 10:01:01

```

**4. Misscelaneous for some commands**

| Command | Flags | Goal |
--- | --- | ---
ls | -l | Same as ll, listing the long information
ls | -a | "a" stands for "all", listing also the hidden files and directories
ls | -s | "s" stands for size
ls | -lS | "S" means that you want the files to be listed sorted by size
ls | -lt | "t" means that you want the files to be listed sorted by time
ls | -ltr | "S" means that you want the files to be listed sorted by time in reverse order
chmod | ugo rwx | "ugo" stands for user group other
chmod | u-r | chmod u-r filename removes the user the right to read
chmod | u+r | chmod u+r filename add the user the right to read
chmod | u+r | chmod u+r, g-rw filename add the user the right to read and removes rw to group
chmod | digital | 7 rwx, 4 r, 5 rx
cp | cp -p | cp -p fileOrigin fileDestination keeps the same rights in the Destination file as the origin one
rm | rm -r test*  + tab | prints the name for all the folders that will be removed by this command
git | git init | git init test_git_error creates a git new folder locally
wc | -w | word count

**5. "Less" command**

| Flags | Purpose |
--- | ---
g | goes to the init of the file
G | goes to the end of the file
q | quit
/ | search, then, pressing "n", it goes from word to word
less -N | add line number
less -S | trim the 
/^ word| search for a line starting by that word
/word this | search for a line ending by word

> Less also mantains the history of the search 

**6. Alias**
To add more alias, edit the file .zshrc on the home directory
- EXPORT makes the variable visible outside the script
- It's important to check the PATH variable, specially when more than one python versions are installed
- which python indicates which python version is in use
- whereis python returns all the possible python
``` bash
dsc@master: ~ % which python                                                           ~ 0 11:59:10
/home/dsc/anaconda3/bin/python
dsc@master: ~ % ls                                                                     ~ 0 11:59:14
anaconda3/  derby.log  Documents/  kkTmp/         Music/     Public/  Repos/      Videos/
Data/       Desktop/   Downloads/  metastore_db/  Pictures/  R/       Templates/
dsc@master: ~ % whereis Music                                                          ~ 0 12:00:33
Music:
dsc@master: ~ % sudo which python                                                      ~ 0 12:00:42
[sudo] password for dsc: 
/usr/bin/python
dsc@master: ~ %                                                                        ~ 0 12:01:07
```
- To create a new alias

**7. Shortcuts**
- ctrl + shift + n: New shell window
- ctrl + shift + t: New tab 
- ctrl + d: Close shell window
- alt + f: forward, word by word
- alt + b: backward, word by word
- ctrl + k: cut
- ctrl + u: remove entire line
- ctrl + l: clean the entire screen
- alt + u : upper case word by word
- ctrl + r: last time that command bas invoked


**8. head and tail commands**
- cat  -n filename | head -n number of lines. Possitive number, takes the first - negative exclude the 

**9. find commands**
- find . -maxdepth 5 -type f -iname "teXt_file*"
- find . -mindepth 5 -type f -iname "teXt_file*"
- find . -mindepth 5 -type f -iname "teXt_file*" -perm 777
- find -empty
- find -maxdepth 2 -not -empty | wc
- find . -size +10M 
- find . -size 10M  ## Search for a file with exactly 10M
- find . -mtime
