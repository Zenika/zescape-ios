#!/bin/bash
 
#Regex
conventional_commit_regex="^(ci|docs|feat|fix|refactor|style|test)(: )(.+)"
 
#Git log & checkout sur la branche courante
git branch -a
git checkout develop
git status
git pull --rebase
 
#Extrait les sha des commits vers un fichier
git log develop --pretty=format:"%H" --not origin/develop > shafile.txt
 
# Parcours du fichier pour récupérer les noms de chaque commit
for i in `cat ./shafile.txt`;
do
# Récupère le nom du commit depuis la valeur du sha
gitmessage=`git log --format=%B -n 1 "$i"`
 
# Vérifie les nommage des commit avec notre regex et si la variable messagecheck est vide, il échoue.
messagecheck=`echo $gitmessage | grep -E "$conventional_commit_regex"`
 
if  [ -z "$messagecheck" ]
then
   # # Uh-oh, quand la convention de nommage n'est pas respectée, on montre un exemple :
   echo "Le commit : $gitmessage - ne respecte pas la convention de commit"
   echo "Un commit valide est sous cette forme : TOTO-XXXX feat: blabla"
   rm shafile.txt >/dev/null 2>&1
   exit 1
fi
done
#On efface le fichier de travail
rm shafile.txt  >/dev/null 2>&1