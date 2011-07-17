#
# Makefile for Adruino project
# Author: Matthieu 'Korrigan' Rosinski <kforkendetta@gmail.com>
#
# This Makefile provide basic rules to build up an Arduino project for
# C or CPP source files (not using .pde project files).
#
# You should edit this Makefile to add your project source files

#########################################################################
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE                #
#                    Version 2, December 2004                           #
#                                                                       #
# Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>			#
#									#
# Everyone is permitted to copy and distribute verbatim or modified	#
# copies of this license document, and changing it is allowed as long	#
# as the name is changed.						#
#									#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE		#
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION	#
# 									#
#  0. You just DO WHAT THE FUCK YOU WANT TO.				#
#                                                                       #
#########################################################################

NAME			=	test

# Config for Arduino Duemilanove, hardware specific
PORT = /dev/ttyUSB0
MCU = atmega328p
F_CPU = 16000000
UPLOAD_RATE = 57600
MAX_SIZE = 30720

# Basepath
ARDUINO			= 	./core
ARD_STDLIB		=	$(ARDUINO)/libarduino.a

# Source files
CXXSRC			=	main.cpp

OBJ			= 	$(SRC:.c=.o) \
			  	$(CXXSRC:.cpp=.o)

# Binaries
CC			= 	avr-gcc
CXX			= 	avr-g++
OBJCOPY			= 	avr-objcopy
SIZE			= 	avr-size
AVRDUDE			= 	avrdude
RM			= 	@rm -fv
STTY			=	stty --file

# Flags
CXXFLAGS		+= 	-mmcu=$(MCU) -DF_CPU=$(F_CPU) \
			  	-Os -W -Wall -ffunction-sections -fdata-sections \
			  	-I$(ARDUINO)

CFLAGS			+=	-mmcu=$(MCU) -DF_CPU=$(F_CPU) \
				-W -Wall -Wextra \
				-std=c99 \
				-I$(ARDUINO)

LDFLAGS       		+= 	-mmcu=$(MCU) -L$(ARDUINO) -larduino -lm -Wl,--gc-sections -Os

AVRDUDE_FLAGS		+=	-V -q -c stk500v1 -b $(UPLOAD_RATE) \
				-C /etc/avrdude.conf

# Rulez
$(NAME):	$(NAME).elf
		$(OBJCOPY) -O ihex -R .eeprom $< $@

$(NAME).elf:	$(OBJ) $(ARD_STDLIB)
		$(CC) -o $@ $(OBJ) $(LDFLAGS)

$(ARD_STDLIB):	$(ARDUINO)
		make -C $(ARDUINO)

%.o:		%.c
		$(CC) $(CFLAGS) -c $< -o $@

%.o:		%.cpp
		$(CXX) $(CXXFLAGS) -c $< -o $@

all:		$(NAME)

upload:		reset raw_upload

reset:
		$(STTY) $(PORT) hupcl
		sleep 0.4
		$(STTY) $(PORT) -hupcl

raw_upload:	$(NAME)
		$(AVRDUDE) $(AVRDUDE_FLAGS) \
		-p$(MCU) -P$(PORT) \
		-Uflash:w:$<:i

clean:
		$(RM) $(OBJ) $(NAME).elf

mrproper:	clean
		$(RM) $(NAME)

re:		mrproper all

.PHONY:		all upload reset raw_upload clean mrproper monitor re
