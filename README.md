# bash_scriptintg

Repositorio con algunos scripts en bash.

## backup_archivos_configuracion.sh 

Script en bash para realizar un backup de los principales archivos de configuración de las aplicaciones instaladas en el pc

## remove_white_spaces.sh

Script en bash renombrar los archivos de un directorio sustituyendo los espacios en blanco por un caracter específicado

## rsync_to_nash:

Script para sincronizar archivos de uno o varios directorios locales con un host remoto utilizando rsync.

Para evitar el uso de contraseñas, requiere haber creado previamente una clave ssh pública y privada y transferir al host remoto la clave pública.

Para hacerlo de forma automática se puede utilizar un cron que ejecute el script con la periodicidad deseada.

## transferencia_archivos.sh

Script para transferir todos los archivos de un directorio a un host remoto mediante la herramienta scp.

Para evitar el uso de contraseñas, requiere haber creado previamente una clave ssh pública y privada y transferir al host remoto la clave pública.

## unir_video_y_audio.sh

Script que recorre todos los ficheros de video de un directorio y por cada uno de ellos busca si existe una pista de audio que corresponda al mismo para generar un archivo final con video y audio.

## vbox_manage.sh

Script en bash para gestionar el uso de máquinas virtuales de VirtualBox, el uso de la interfaz de líneas de comandos VBoxManage. El script da la opción de listar las máquinas virtuales existentes, además de arrancar, parar y guardar el estado de una máquina virtual específica.
