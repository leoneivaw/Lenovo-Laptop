#!/bin/bash

[ "$UID" -eq 0 ] || exec sudo "$0" "$@"
carga=$(cat /sys/class/power_supply/BAT*/capacity)
echo ""
echo "***Bateria IdeaPad***"
echo "***Carga atual $carga%***"
echo ""
echo "1) Habilitar modo de conservação"
echo "2) Desabilitar modo de conservação"
echo "3) Status da bateria"
echo "4) Sair"
echo ""

read sw

if [ $sw -eq 1 ]
then
	echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
	echo ""
	echo "Modo de conservação habilitado."
	echo " :) "
	echo ""
fi
if [ $sw -eq 2 ]
then
	echo 0 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
	echo ""
	echo "Modo de conservação desabiltado."
	echo "......."
	echo ""
fi
if [ $sw -eq 3 ] 
then
	if grep -q 1 /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode;
	then 
		echo ""
		echo "MODO DE CONSERVAÇÃO HABILITADO. << $carga% >>"
				echo ""
				upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state|to\ full|capacity|voltage"
	fi
	if grep -q 0 /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode;
	then
		echo ""
		echo "MODO DE CONSERVAÇÃO DESABILITADO.  << $carga% >>"
				echo ""
								upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state|to\ full|capacity|voltage"
	fi
fi

if [ $sw -eq 4 ]
then
	echo 
	echo ""
	echo "Sair"
    echo "***Carga atual $carga%***"
	echo ""
fi

