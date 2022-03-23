#!/bin/bash

function display_help() {
  readonly script_name="./$(basename "$0")"

  echo "This script updates versions and the 'releaseDate' in pom.yml during a release."
  echo "Use for standard final releases only, as it does not distinguish between 'latest' and 'latestFinal' versions."
  echo
  echo "Usage:"
  echo "  $script_name CURRENT_KIE_FINAL_VERSION NEW_KIE_FINAL_VERSION"
  echo "  $script_name --help"
}

if [[ $1 == "--help" ]]; then
  display_help
  exit 0
fi

if [[ $# -ne 2 ]]; then
  echo "Illegal number of arguments."
  display_help
  exit 1
fi

readonly current_final=$1
readonly new_final=$2


this_script_directory="${BASH_SOURCE%/*}"
if [[ ! -d "$this_script_directory" ]]; then
  this_script_directory="$PWD"
fi

touch repos.txt
echo "business-central/base/" > repos.txt
echo "business-central/showcase/" >> repos.txt
echo "business-central/kie-server/base/" >> repos.txt
echo "business-central/kie-server/showcase/" >> repos.txt
echo "business-central/server/" >> repos.txt

cat repos.txt

PATH_LIST=`cat repos.txt`

exitCode=0

for pathTo in $PATH_LIST ; do
  sed -i -E "s/$current_final/$new_final/g" ../$pathTo/README.md # changes the version in all READMES
  sed -i -E "s/$current_final/$new_final/g" ../$pathTo/Dockerfile # changes the version in all Dockerfiles
  sed -i -E "s/$current_final/$new_final/g" ../$pathTo/build.sh # change IMAGE_TAG
  sed -i -E "s/$current_final/$new_final/g" ../$pathTo/start.sh # change IMAGE_TAG
done

sed -i -E "s/$current_final/$new_final/g" ../business-central/docker-compose-examples/bc-kie-server.yml # change IMAGE_TAG


rm -rf repos.txt

exit $exitCode

