#!/bin/bash

folder=cfg/uavxp
filename=setting.cfg

mkdir -p $folder
touch $folder/$filename
> $folder/$filename

cpu=
gpu=
minfps=30
network=

buff=

echo "Is your CPU good (Y/N, default: N):"
read buff
if [ "$buff" = "Y" ] || [ "$buff" = "y" ]; then
	cpu=highend
else
	cpu=lowend
fi

echo "Is your GPU good (Y/N, default: N):"
read buff
if [ "$buff" = "Y" ] || [ "$buff" = "y" ]; then
	gpu=highend
else
	gpu=lowend
fi

echo "What is your average FPS in-game (10-60, default: 30):"
read buff
if [ ! -z "$buff" ]; then
	minfps=$buff
fi

echo "Is your network good (e.q. wired connection) (Y/N, default: N):"
read buff
if [ "$buff" = "Y" ] || [ "$buff" = "y" ]; then
	network=highend
else
	network=lowend
fi

#echo $cpu $gpu $minfps $network
echo ""

echo uavxp_${cpu}_cpu >> $folder/$filename
echo uavxp_${gpu}_gpu >> $folder/$filename
echo cl_cmdrate ${minfps} >> $folder/$filename
echo cl_updaterate ${minfps} >> $folder/$filename
if [ "$network" = "highend" ]; then
	echo cl_interp_ratio 1 >> $folder/$filename
else
	echo cl_interp_ratio 2 >> $folder/$filename
fi
echo cl_interp 0 >> $folder/$filename

# Intel-specific bug on Mesa, Linux
# https://github.com/ValveSoftware/Source-1-Games/issues/3443
# For me, enabling bumpmaps helps immediately
echo mat_bumpmap 1 >> $folder/$filename
#echo mat_phong 1 >> $folder/$filename
# Maybe, even this:
#echo mat_specular 1 >> $folder/$filename

echo "Check your custom config here:"
echo ""

cat $folder/$filename
