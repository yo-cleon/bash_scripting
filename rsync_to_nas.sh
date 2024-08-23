####################################################################################
##                                                                                ##
##                             DESARROLLADO POR CLR                               ##
##                                                                                ##
## Script para mantener sincronizados algunos directorios locales con el equipo   ##
## nas.                                                                           ##
##                                                                                ##
##                                                                                ##
####################################################################################


#!/bin/bash

# put current date as yyyy-mm-dd HH:MM:SS in $date
DIR_C3PO="/media/peter/C3PO"
LOG_FILE="/var/log/rsync_to_nas.log"
date=$(date '+%Y-%m-%d %H:%M:%S')

function add_linea(){
    echo "===================" >> $LOG_FILE
}

# TODO: Revisar volcado a fichero log no hacerlo línea a línea
add_linea
echo $date >> $LOG_FILE
add_linea
echo "" >> $LOG_FILE

# Sincronización Preparacion GSI
if mountpoint -q $DIR_C3PO 
then
    echo "Preparacion_GSI" >> $LOG_FILE
    add_linea
    echo "Sincronizando clases" >> $LOG_FILE
    rsync -av $DIR_C3PO/Preparacion_gsi/clases/ nas:/volume1/docker/volumes/jellyfin/media/Preparacion_GSI/clases 2>&1 | tee -a $LOG_FILE
    add_linea
    echo "Sincronizando clases antiguas" >> $LOG_FILE
    rsync -av $DIR_C3PO/Preparacion_gsi/Clases_Antiguas/ nas:/volume1/docker/volumes/jellyfin/media/Preparacion_GSI/Clases_Antiguas 2>&1 | tee -a $LOG_FILE
    echo "" >> $LOG_FILE
else
    echo "El directorio  $DIR_C3PO no está disponible"  >> $LOG_FILE
fi
# Fin script
add_linea
echo "" >> $LOG_FILE