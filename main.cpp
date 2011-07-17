//
// main.cpp for arduino in /home/korrigan/dev/arduino-makefile
// 
// Made by Matthieu Rosinski
// Login   <korrigan@epitech.net>
// 
// Started on  Sun Jul 17 15:53:37 2011 Matthieu Rosinski
// Last update Sun Jul 17 15:53:37 2011 Matthieu Rosinski
//

#include	"WProgram.h"

int		main(void)
{
  init();
  pinMode(13, OUTPUT);
  while (42)
    {
      digitalWrite(13, HIGH);
      delay(500);
      digitalWrite(13, LOW);
      delay(500);
    }
  return (0);
}
