####################################################################################
##                                                                                ##
##                             DESARROLLADO POR CLR                               ##
##                                                                                ##
## Script en bash para añadir a un video una pista de audio existente.            ##
##                                                                                ##
## El script se ejecuta en el mismo directorio en el que se encuentran las pistas ##
## de audio y video y tendrán el mismo nombre.                                    ##
##                                                                                ##
## Se recorrena todos los archivos de video del directorio con una determinada    ##
## extensión de video y busca una pista de audio con el mismo nombre. Si el       ##
## fichero de audio existe, se procede a realizar la unión generando un nuevo     ## 
## archivo de video.                                                              ##
##                                                                                ##
## Más información en:                                                            ##
## https://www.adictosaltrabajo.com/2015/12/30/unir-multiples-videos-a-la-vez-con ##
## -ffmpeg-y-bash/                                                                ##
##                                                                                ##
####################################################################################


#!/bin/bash

# Capturamos por teclado la extensión de video y audio a mezclar y la opción
# de borrar los archvios originales.
read -p "Introduce la extensión de los archivos de video a mezclar (sin punto)_ " video_ext
read -p "Introduce la extensión de los archivos de audio a mezclar (sin punto)_ " audio_ext
read -p "¿Deseas borrar los archivos originales? (s/n) " borrar_archivos

echo "Recorremos el directorio actual buscando archivos de video..."
for video in *.$video_ext
  do
    echo  "Pista de video -> ${video}"
    # Del fichero de video eliminamos la extensión y construimos el nombre
    # del fichero de audio
    filename=$(echo "$video" | cut -f 1 -d '.')
    audio="$filename".$audio_ext
    echo " Pista de audio -> ${audio}"
    if [ -f $audio ]; then
      video_final="$filename"_final.$video_ext
      # Pasamos los archivos de video y audio y de cada uno de ellos, nos aseguramos
      # de obtener la pista correcta, porque un archivo puede contener varias
      # pistas
      ffmpeg -i $video -i $audio -c copy -map 0:v:0 -map 1:a:0 $video_final
      echo " Generado archivo ${video_final}"
      # Se eliminan los archivos separados
      if [[ ${borrar_archivos,,} == "s" ]]; then
        rm -f $video $audio
      fi
    else
      echo "No existe la pista de audio ${audio}"
    fi
  done;
