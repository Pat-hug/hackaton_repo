# Notes

garder  l'adresse e-mail privée:
    setting => email => cocher Keep my email private
    email original: @github.com
    email privée: @user.noreply.github.com





# Bandit niveaux
commande pour passer le niveau
lvl 1 : cat ./-
lvl 2 : cat "./--spaces in this filename--"
lvl 3 : cat "./...Hiding-From-You"
lvl 4 : cat "./-file"*
lvl 5 : find ./inhere -type f -size 1033c ! -executable
lvl 6 : find / -type f -user bandit7 -group bandit6 -size 33c 2>/dev/null
lvl 7 : grep millionth ./data.txt
lvl 8 : sort data.txt | uniq -u
lvl 9 : strings data.txt | grep "==="
lvl 10 : base64 -d
lvl 11 : cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
lvl 12 : mv data.bin data.gz => gunzip data.gz | mv data.bin data.bz2 => bunzip2 data.bz2 | POSIX tar = tar -xf data.bin
lvl 13 : ssh key
lvl 14 : ssh key
lvl 15 : utiliser key port 30000
lvl 16 : connection ssl 