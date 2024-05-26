#! /bin/bash

####################################################################################
##                                                                                ##
##                             DESARROLLADO POR CLR                               ##
##                                                                                ##
## Script en bash para eliminar los espacios en blanco de los nombres de todos    ##
## los ficheros de un directorio                                                  ##
##                                                                                ##
## Para llamar al script es necesario pasarle dos argumentos:                     ##
## - La ruta del directorio que contiene los ficheros a renombrar                ##
## - El caracter por el que queremos sustituir los espacios en blanco             ## 
##                                                                                ##
## Se genera un listado con los ficheros renombrados.                             ##
##                                                                                ##
####################################################################################

function renombrarFicheros(){
    fecha=$(date '+%Y-%m-%d %H:%M:%S')
    for file in $ruta/* ; do
        if [[ -f "${file}" ]] 
        then
            f=$(echo $(basename "$file") | tr " " $caracter)
            if [[ "$file" != "$f" ]]
            then
                mv "$file" $ruta/$f
                echo "$fecha - $file - $ruta/$f" >> $ruta/ficheros_renombrados.txt
            fi
        fi
    done
}

function checkParameters(){
    
    if [[ $# -eq 0 ]] ; then
        echo "Es necesario indicar la directorio de trabajo"
        exit 1
    elif [[ $# -eq 2 ]] ; then
        if [[ "$1" == "." ]] ; then
            ruta=$(pwd)
        else
            ruta=$1
        fi
        caracter=$2
        echo "$ruta"
        if [[ ! -d $ruta ]] ; then
            echo "El primer parámetro debe ser un directorio"
            exit 1
        else
            renombrarFicheros $ruta $caracter
        fi
    elif [[ $# -gt 2 ]] ; then
        echo "Se han recibido más parámetros de los necesarios"
    else
        echo "La ruta a revisar es $1. Sustituyendo espacios en blanco por $2"  
    fi
}


checkParameters $@

