#
# Makefile for Arduino core source files
# Author: Matthieu 'Korrigan' Rosinski <kforkendetta@gmail.com>
#
# This Makefile builds a static library which contains Arduino's
# standard Library and different tools
#

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

# Config for Arduino Duemilanove, hardware specific
MCU = atmega328p
F_CPU = 16000000

# Source files
NAME			= 	libarduino.a

SRC			+=	pins_arduino.c \
				wiring.c \
				wiring_analog.c \
				wiring_digital.c \
				wiring_pulse.c \
				wiring_shift.c \
				WInterrupts.c

CXXSRC 			+= 	HardwareSerial.cpp \
				WMath.cpp \
				Print.cpp

OBJ			= 	$(SRC:.c=.o) \
			  	$(CXXSRC:.cpp=.o)

# Binaries
CC			= 	avr-gcc
CXX			= 	avr-g++
OBJCOPY			= 	avr-objcopy
AR			= 	avr-ar -rcsv
SIZE			= 	avr-size
RM			= 	@rm -fv

# Flags
CXXFLAGS		+= 	-mmcu=$(MCU) -DF_CFU=$(F_CPU) \
			  	-Os -W -Wall -ffunction-sections -fdata-sections

CFLAGS			+=	-mmcu=$(MCU) -DF_CFU=$(F_CPU) \
				-W -Wall -Wextra \
				-std=c99

# Rulez

$(NAME):	$(OBJ)
		$(AR) $@ $^

%.o:		%.c
		$(CC) $(CFLAGS) -c $< -o $@

%.o:		%.cpp
		$(CXX) $(CXXFLAGS) -c $< -o $@

all:		$(NAME)

clean:
		$(RM) $(OBJ)

mrproper:	clean
		$(RM) $(NAME)

re:		mrproper all

.PHONY:		all  clean mrproper re
