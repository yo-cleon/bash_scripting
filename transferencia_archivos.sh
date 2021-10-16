####################################################################################
##                                                                                ##
##                             DESARROLLADO POR CLR                               ##
##                                                                                ##
## Script en bash para transferir todos los archivos a un host remoto mediante    ##
## la herramienta scp.                                                            ##
##                                                                                ##
## Para evitar usar usuario y contraseña, deberemos haber creado primero un par   ##
## de claves públicas y privadas, y transferir al host remoto la clave pública.   ##
##                                                                                ##
## El script también ofrece la posibilidad de eliminar todos los ficheros del     ##
## directorio de origen una vez finalizada la transferencia de los archivos.      ##
##                                                                                ##
####################################################################################

#!/bin/bash

# Variables globales del script.
borrar_archivo=$1
user=
origen=
host=
destination=

# Si no se puede conectar con el host remoto se
# interrumpe la ejecución del script
error_exit(){
  echo "No se ha podido realizar la transferencia de archivos"
  echo "-----------------------------"
  exit 1
}

echo "-----------------------------"
echo "  Transfiriendo archivos...  "
if [ $(ls $origen | wc -l) -gt 0 ]; then
  scp -r $origen $user@$host:/$destination || error_exit
else
  echo "No hay archivos para transferir"
  exit
fi
echo "  ...archivos transferidos  "
echo "-----------------------------"

# Si no se ha pasado ningún parámetro en la ejecución se solicita
# confirmación para el borrado de archivos.
if [ "$borrar_archivo" == "" ];then
  read -p "¿Quieres eliminar los archivos finalizada la transferencia? (s/n) " borrar_archivo
fi

if [[ "${borrar_archivo,,}" == 's' || "${borrar_archivo,,}" == "-s" ]]; then
  rm -r $origen/*
  echo "Eliminados todos los archivos de $origen"
  echo "Proceso finalizado"
  echo "-----------------------------"
elseif [[ "${borrar_archivo,,}" == 'n' || "${borrar_archivo,,}" == "-n" ]]; then
  echo "Proceso finalizado"
  echo "-----------------------------"
else
  echo "Opción incorrecta. Proceso finalizado"
  echo "-----------------------------"
fi

