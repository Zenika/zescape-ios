echo "toto" $1
VERSION=$(git tag --sort=-v:refname --merged HEAD | grep -E "$1" | head -1)

if [ "$VERSION" = "" ]
then
  echo "Pas de version trouvée correspondante à la regex $1"
  exit 1
else
  echo "$VERSION"
fi