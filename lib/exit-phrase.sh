#!/bin/bash

function exitPhrase()
{

    declare -a exitPhrases

    exitPhrases=(
        'Good luck on your new adventure'
        'Have fun with your new project'
    )

    exitPhrasesLength=(${#exitPhrases[@]})
    ((exitPhrasesLength--))

    selectedPhraseIndex=$(shuf -n 1 -i 0-$exitPhrasesLength)

    printf "You are all setup... ${exitPhrases[$selectedPhraseIndex]}! \n"

}
