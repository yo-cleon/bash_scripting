#!/bin/bash

####################################################################################
##                                                                                ##
##                             DESARROLLADO POR CLR                               ##
##                                                                                ##
## Script en bash para gestionar el uso de máquinas virtuales de VirtualBox,      ##
## el uso de la interfaz de líneas de comandos VBoxManage.                        ##
##                                                                                ##
## El script da la opción de listar las máquinas virtuales existentes, además de  ##
## arrancar, parar y guardar el estado de una máquina virtual específica          ##
##                                                                                ##
####################################################################################
# Si no se puede conectar con el host remoto se
# interrumpe la ejecución del script
error_exit(){
  echo "$1"
  echo "-----------------------------"
  exit 1
}

function mostrar_ayuda(){
  echo "El uso correcto del script es:  ./vbox_manage.sh [PARAMETRO]"
  echo "Parámetros:"
  echo " -list: muestra un listado de las máquinas virtuales existentes"
  echo " -on <vm>: arranca una máquina virtual"
  echo " -off <vm>: apaga una máquina virtual"
  echo " -save <vm>: guarda el estado de la máquina virtual"
  echo " -h, -help: muestra la ayuda del script"
}

# COMPROBACIÓN DE LOS PARÁMETROS RECIBIDOS
function comprobar_parametros(){
  if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    mostrar_ayuda
  else
    #for param in $*; do
    while [ ! -z "$1" ] ; do
        #case "$param" in
        case "$1" in
          -list)
            shift
            listar_maquinas
            ;;
          -on)
            shift
            arrancar_maquina $1
            ;;
          -off)
            shift
            apagar_maquina $1
            ;;
          -save)
            shift
            guardar_maquina $1 
            ;;
          -h | -help)
            shift
            mostrar_ayuda
            ;;
          *)
            echo "Opcion $1 invalida"
            mostrar_ayuda
            ;;
        esac
      shift
      done
  fi
}

function listar_maquinas(){
  echo "Listando las máquinas virtuales existentes..."
  # TODO: lograr que se muestre únicamente el nombre de la máquina
  # y ocultar el uuid
  vboxmanage list vms || error_exit "Error al listar las máquinas virtuales"
  #awk -F:" " '{print S0}' | vboxmanage list vms 2>/dev/null
  # vms=$(vboxmanage list vms)
  # for vm in $vms ; do
  #   echo " $vm"
  # done
  echo ""
  echo "Máquinas listadas correctamente"
}

function comprobar_estado(){
  local retval=$(vboxmanage showvminfo $1 | grep State | awk -F: '{ gsub(/ /,""); print $2 }' | awk -F"(" '{ print $1 }')
  echo $retval
}

function arrancar_maquina(){
  echo "Arrancando la máquina $1"
  state=$(comprobar_estado $1)
  if [ "$state" == "running" ]; then
    echo "La máquina $1 ya está corriendo"
  else
    vboxmanage startvm $1  --type=headless || error_exit "Error al iniciar la máquina virtual $1"
  fi
}

function guardar_maquina(){
  echo "Guardando el estado de la máquina $1" 
  state=$(comprobar_estado $1)
  if [ "$state" == "running" ]; then
    vboxmanage controlvm $1 savestate || error_exit "Error al guardar el estado de la máquina virtual $1"
    echo "Estado guardado correctamente"
  else
    echo "La máquina $1 no está corriendo"
  fi
}
function apagar_maquina(){
  echo "Apagando la máquina $1"
  state=$(comprobar_estado $1)
  if [ "$state" == "running" ]; then
    vboxmanage controlvm $1 poweroff || error_exit "Error apagando la máquina virtual $1"
    echo "Máquina apagada correctamente"
  else
    echo "La máquina $1 no está corriendo"
  fi
}

echo "-----------------------------"
comprobar_parametros $@
echo "-----------------------------"
