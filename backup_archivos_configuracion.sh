#!/bin/bash

user=$(awk -v uid=1000 -F":" '{ if($3==uid){print $1} }' /etc/passwd)
destination_dir="/mnt/data/ProyectosUnix/Post_Instalacion/Linux_Mint_Cinnamon/src"
log_file="/var/log/backup_config_file.log"

# FUNCIONES UTILIZADAS
function respaldo_correcto(){
  echo "$salida" >> $log_file
  echo "...respaldo realizado correctamente." >> $log_file
  echo "============================================" >> $log_file
}

function respaldo_erroneo(){
  echo "Error en el respaldo. Cod. error: $CODSAL_TERMINATOR" >> $log_file
  echo -e "$salida" >> $log_file
  echo "...no se ha podido realizar el respaldo." >> $log_file
  echo -e "============================================" >> $log_file
}

function inicializacion(){
  echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"  >> $log_file
  echo "$(date +%Y_%m_%d-%H_%M_%S) - Iniciando respaldo de archivos de configuración" >> $log_file
  echo -e "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n" >> $log_file
}

function finalizacion(){
  echo -e "\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" >> $log_file
  echo "            $(date +%Y_%m_%d-%H_%M_%S) - Finalizado el respaldo" >> $log_file
  echo -e "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n" >> $log_file
}

inicializacion

# BACKUP CONFIGURACIÓN TERMINATOR
echo -e "============================================" >> $log_file
echo -e "$(date +%Y_%m_%d-%H_%M_%S)\nREALIZANDO RESPALDO DE LA CONFIGURACIÓN DE TERMINATOR..." >> $log_file
salida=$(rsync -av /home/${user}/.config/terminator/config ${destination_dir}/terminator/config 2>&1)
CODSAL_TERMINATOR=$?
if [ "$CODSAL_TERMINATOR" -eq "0" ] ; then
  respaldo_correcto $salida
else
  respaldo_erroneo $CODSAL_TERMINATOR $salida
fi

# BACKUP CONFIGURACIÓN CONKY
echo -e "$(date +%Y_%m_%d-%H_%M_%S)\nREALIZANDO RESPALDO DE LA CONFIGURACIÓN DE CONKY..." >> $log_file
salida=$(rsync -av /etc/conky/conky.conf ${destination_dir}/conky/conky.conf 2>&1)
CODSAL_CONKY_1=$?
if [ "$CODSAL_CONKY_1" -eq "0" ] ; then
  respaldo_correcto $salida
else
  respaldo_erroneo $CODSAL_CONKY_1 $salida
fi

echo -e "$(date +%Y_%m_%d-%H_%M_%S)\nREALIZANDO RESPALDO DEL SCRIPT DE AUTOARRANQUE DE CONKY..." >> $log_file
salida=$(rsync -av /home/${user}/.config/autostart/Conky.desktop ${destination_dir}/conky/Conky.desktop 2>&1)
CODSAL_CONKY_2=$?
if [ "$CODSAL_CONKY_2" -eq "0" ] ; then
  respaldo_correcto $salida
else
  respaldo_erroneo $CODSAL_CONKY_2 $salida
fi

# BACKUP CONFIGURACIÓN SSH
echo -e "$(date +%Y_%m_%d-%H_%M_%S)\nREALIZANDO RESPALDO DE LA CONFIGURACIÓN SSH..." >> $log_file
salida=$(rsync -av /etc/ssh/ssh_config ${destination_dir}/ssh/ssh_config 2>&1)
CODSAL_SSH=$?
if [ "$CODSAL_SSH" -eq "0" ] ; then
  respaldo_correcto $salida
else
  respaldo_erroneo $CODSAL_SSH $salida
fi
salida_host=$(rsync -av /etc/ssh/ssh_config ${destination_dir}/ssh/ssh_config 2>&1)
CODSAL_SSH_HOST=$?
if [ "$CODSAL_SSH_HOST" -eq "0" ] ; then
  respaldo_correcto $salida_host
else
  respaldo_erroneo $CODSAL_SSH_HOST $salida_host
fi

# BACKUP CONFIGURACIÓN ATOM
echo -e "$(date +%Y_%m_%d-%H_%M_%S)\nREALIZANDO RESPALDO DE LA CONFIGURACIÓN DE ATOM..." >> $log_file
salida=$(rsync -av /home/${user}/.atom/config.cson  ${destination_dir}/atom/config.cson 2>&1)
CODSAL_ATOM=$?
if [ "$CODSAL_ATOM" -eq "0" ] ; then
  respaldo_correcto $salida
else
  respaldo_erroneo $CODSAL_ATOM $salida
fi

# TODO: BACKUP PAQUETES DE ATOM
# REVISAR POR QUÉ DESDE EL CRON NO SE EJECUTA LA ORDEN APM COMO EL USUARIO PETER
#echo -e "$(date +%Y_%m_%d-%H_%M_%S)\nREALIZANDO RESPALDO DE LOS PAQUETES DE ATOM..." >> $log_file
#salida=$(sudo  -l peter apm list --installed --bare > ${destination_dir}/atom/packages.txt 2>&1)
#CODSAL_ATOM_PACK=$?
#echo "$CODSAL_ATOM_PACK" >> $log_file
#if [ "$CODSAL_ATOM_PACK" -eq "0" ] ; then
#  respaldo_correcto $salida
#else
#  respaldo_erroneo $CODSAL_ATOM_PACK $salida
#fi


finalizacion
