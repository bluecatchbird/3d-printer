#!/bin/sh
#
# howto flash your melzi board with marlin sw
# on arch linux
# from: http://reprap.org/wiki/Melzi
#


# install arduino ide from aur repo
yaort -S arduino


# now get latest reprap marlin sw with
# the sanguino file for a new arduino hardware
git clone https://github.com/reprappro/Marlin


# bugfix for new arduino hardware config syntax
# see: https://github.com/arduino/Arduino/issues/2527
patch -p0 << EOF
diff --git a/Marling/sanguino/boards.txt b/Marlin/sanguino/boards.txt
index 52ebfac..5d3b592 100644
--- a/sanguino/boards.txt
+++ b/sanguino/boards.txt
@@ -2,21 +2,25 @@
 
 atmega1284.name=Melzi 1284p 16mhz
 
-atmega1284.upload.protocol=stk500v1
+atmega1284.upload.protocol=arduino
 atmega1284.upload.maximum_size=129024
+atmega1284p.upload.maximum_data_size=16384
 atmega1284.upload.speed=57600
 
 atmega1284.bootloader.low_fuses=0xd6
 atmega1284.bootloader.high_fuses=0xdc
 atmega1284.bootloader.extended_fuses=0xfd
 atmega1284.bootloader.path=atmega
-atmega1284.bootloader.file=ATmegaBOOT_1284P.hex
+atmega1284.bootloader.file=atmega/ATmegaBOOT_1284P.hex
 atmega1284.bootloader.unlock_bits=0x3F
 atmega1284.bootloader.lock_bits=0x0F
 
 atmega1284.build.mcu=atmega1284p
 atmega1284.build.f_cpu=16000000L
-atmega1284.build.core=arduino
+atmega1284.build.core=arduino:arduino
 atmega1284.build.variant=standard
 
+atmega1284.upload.tool=arduino:avrdude
+atmega1284.bootloader.tool=arduino:avrdude
EOF


# install arduino hardware config data
mkdir -p /usr/share/arduino/hardware/sanguino/avr/
rsync -rl Marlin/sanguino/* /usr/share/arduino/hardware/sanguino/avr/


# no install bootloader for
# see: http://reprap.org/wiki/Melzi#Bootloader_Upload


# open marlin sw in arduino ide
arduino Marlin/Marlin/


# int the file Configuration.h
# uncomment the line for the melzi board
# #define REPRAPPRO_MELZI

# uncomment your series resistors
# #define SERIAL_R  4700

# uncomment your printer type
# #define REPRAPPRO_MENDEL

# to disable safty features uncomment
# #define DEVELOPING

# uncomment your baudrate
# #define BAUDRATE 250000


# now you can flash the sw on the melzi board
# by clicking on "upload" in the arduino ide
