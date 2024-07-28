#!/bin/bash

json=$(curl -o out.json -s https://frasedeldia.azurewebsites.net/api/phrase )
frase=$(jq '.phrase' out.json)
autor=$(jq '.author' out.json | sed 's/\"//g') 
rm out.json
echo "$frase $autor"
