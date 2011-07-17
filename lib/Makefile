##
## Makefile for arduino-mk in /home/korrigan/dev/arduino-mk/lib/EEPROM
## 
## Made by Matthieu Rosinski
## Login   <korrigan@epitech.net>
## 
## Started on  Sun Jul 17 16:41:46 2011 Matthieu Rosinski
## Last update Sun Jul 17 16:41:46 2011 Matthieu Rosinski
##

# Config for Arduino Duemilanove, hardware specific
MCU = atmega328p
F_CPU = 16000000

# Binaries
CC			= 	avr-gcc
CXX			= 	avr-g++
OBJCOPY			= 	avr-objcopy
AR			= 	avr-ar -rcsv
SIZE			= 	avr-size
RM			= 	@rm -fv
CP			= 	@cp -v

# OBJ
OBJ			=	$(SRC:.c=.o) $(CXXSRC:.cpp=.o)

# Flags
CXXFLAGS		+= 	-mmcu=$(MCU) -DF_CPU=$(F_CPU) \
			  	-Os -W -Wall -ffunction-sections -fdata-sections \
				-I../../core -I../inc

CFLAGS			+=	-mmcu=$(MCU) -DF_CPU=$(F_CPU) \
				-W -Wall -Wextra \
				-std=c99 \
				-I../../core -I../inc

# Rulez
$(NAME):	$(OBJ)
		$(AR) $@ $^

%.o:		%.c
		$(CC) $(CFLAGS) -c $< -o $@

%.o:		%.cpp
		$(CXX) $(CXXFLAGS) -c $< -o $@

lib%.a:		%
		make -C $< all

all:		$(NAME)
		$(CP) $< ..

clean:
		$(RM) $(OBJ)

mrproper:	clean
		$(RM) $(NAME)

re:		mrproper all

.PHONY:		all clean mrproper re
