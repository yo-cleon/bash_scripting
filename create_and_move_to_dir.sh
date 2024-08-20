#! /bin/bash

####################################################################################
##                                                                                ##
##                             DESARROLLADO POR CLR                               ##
##                                                                                ##
## Script en bash para crear un directorio en base a una parte del nombre de un   ##
## archivo y mover el archivo dentro de ese directorio.                           ##
##                                                                                ##
## Para llamar al script es necesario pasarle dos argumentos:                     ##
## - La ruta del directorio que contiene los ficheros a renombrar                 ##
## - El caracter utilizado de separador en el nombre de los fichero               ## 
## - El sector del nombre del archivo utilizado para crear el directorio          ##
##                                                                                ##
## Es necesario que todos los ficheros tengan la misma estructura para que la     ##
## los directorios se creen de la misma forma.                                    ##
##                                                                                ##
####################################################################################

#function renombrarFicheros(){
#    fecha=$(date '+%Y-%m-%d %H:%M:%S')
#    for file in $ruta/* ; do
#        if [[ -f "${file}" ]] 
#        then
#            f=$(echo $(basename "$file") | tr " " $caracter)
#            if [[ "$file" != "$f" ]]
#            then
#                mv "$file" $ruta/$f
#                echo "$fecha - $file - $ruta/$f" >> $ruta/ficheros_renombrados.txt
#            fi
#        fi
#    done
#}
function createFolder(){
		if [[ -d $ruta$folder ]] ; then
			echo "$folder ya existe"
		else
			mkdir $ruta$folder
		fi
}
function listFiles(){
    if [[ "$1" == "." ]] ; then
        ruta=$(pwd)
    else
        ruta=$1
    fi
    if [[ ! -d $ruta ]] ; then
        echo "El primer parámetro debe ser un directorio"
        exit 1
    fi
    caracter=$2
		sector=$3 
    echo "Argumentos: 1. $ruta - 2. $caracter - 3. $sector"

    for file in $ruta/* ; do
      if [[ -f "${file}" ]] ; then
				# El indicador -v de awk precede a un espacio, un nombre de variable, un signo igual = y el valor de la variable. 
				# Es importante destacar que este último puede ser un valor de shell interpolado. Luego, cada variable se puede usar 
				# dentro del script como de costumbre. Para múltiples variables, proporcionamos -v tantas veces como sea necesario.
				folder=$(echo $(basename $ruta/$file | awk -v s="$sector" -F "$caracter" '{print $s}' | sed -E 's/(_|\.|\-|\s)$//'))
				#caracter_final=$(echo "$folder" | tail -c 2)
	      if [[ -d $ruta$folder ]] ; then
				   echo "$folder ya existe"
				else
				  mkdir $ruta$folder
					echo "Creado directorio $folder"
				fi
				file_name=$(echo $(basename $file))
				mv $file $ruta$folder/$file_name
				echo "Movido fichero $file_name"
      fi
    done

}

function checkParameters(){
    
    if [[ $# -eq 0 ]] ; then
        echo "No se ha indicado ningún parámetro. Debe indicar la ruta a revisar, un separador para dividir el nombre de los archivos y qué parte del archvio se uitlizará para crear los subdirectorios."  
        exit 1
    elif [[ $# -lt 3 ]] ; then
        echo "Se han indicado menos parámetros de los necesarios. Debe indicar la ruta a revisar, un separador para dividir el nombre de los archivos y qué parte del archvio se uitlizará para crear los subdirectorios."  
    elif [[ $# -gt 3 ]] ; then
        echo "Se han recibido más parámetros de los necesarios. Debe indicar la ruta a revisar, un separador para dividir el nombre de los archivos y qué parte del archvio se uitlizará para crear los subdirectorios."
				exit 1
#    else
#        echo "Es necesario indicar la directorio de trabajo, un separador para el nombre del archivo y qué parte del nombre del fichero se utilizará par crear los directorios"
#				exit 1
    fi
}


checkParameters $@
listFiles $@
