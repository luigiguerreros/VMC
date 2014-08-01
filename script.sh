#!/bin/bash

declare -a REPO     # Array - Repositories
declare -a BRANCH   # Array - Branches
declare -a FOLDER   # Array - Local repository

XX="\e[38;5;32m"

RED="\e[01;31m"
GREEN="\e[00;32m"
YELLOW="\e[01;33m"
BLUE="\e[00;92m"
NORMAL="\e[00m"


#--- Website -------------------------------------------------------------------
GROUP[0]="web"
NAME[0]="Website"
BRANCH[0]="release"
FOLDER[0]="/home/luigi/VMC"

#--- Git -----------------------------------------------------------------------
for (( index=0; index < ${#GROUP[@]}; index++ )) ; do
    cd ${FOLDER[index]}

    CURRENT=$(git rev-parse --abbrev-ref HEAD)

    echo -e "  Repositorio\t: [${BLUE}${GROUP[index]^}${NORMAL}]  ${NAME[index]}"
    echo -e "  Rama\t\t: ${CURRENT^^}"

    # Set Branch
    if [ "${BRANCH[index]}" != "$CURRENT"  ] ; then
        echo -e "  - Cambiando a rama ${BRANCH[index]}"
        git checkout ${BRANCH[index]} #--quiet
    fi

    git fetch #--quiet

    # Pull Changes
    CHANGES=$(git status | grep "behind" | awk '{print $8}')

    if [[ ! $CHANGES -eq "" ]] ; then
        echo -e "  ${RED}- El repositorio se actualizara${NORMAL}"
        echo -e "  - Commits:  ${CHANGES}"

        STAGED=$(git status --porcelain | wc -l)

        if [ $STAGED -ge 1 ]; then
                echo -e "  - Ocualtamos cambios locales"
                git stash #--quiet
        fi

        git pull

        if [ $STAGED -ge 1 ]; then
                echo -e "  - Recuperamos cambios locales"
                git stash pop #--quiet
        fi

        echo
    else
        echo -e "  ${XX}- El repositorio está actualizado${NORMAL}"
        echo
    fi
done

exit
