# bash_scriptintg

Repositorio con algunos scripts en bash.

## unir_video_y_audio.sh

Script que recorre todos los ficheros de video de un directorio y por cada uno de ellos busca si existe una pista de audio que corresponda al mismo para generar un archivo final con video y audio.

## transferencia_archivos.sh

Script para transferir todos los archivos de un directorio a un host remoto mediante la herramienta scp.

Para evitar el uso de contraseñas, requiere haber creado previamente una clave ssh pública y privada y transferir al host remoto la clave privada.

## vbox_manage.sh

Script en bash para gestionar el uso de máquinas virtuales de VirtualBox, el uso de la interfaz de líneas de comandos VBoxManage. El script da la opción de listar las máquinas virtuales existentes, además de arrancar, parar y guardar el estado de una máquina virtual específica.

## Backup configuración

Script en bash para realizar un backup de los principales archivos de configuración de las aplicaciones instaladas en el pc
