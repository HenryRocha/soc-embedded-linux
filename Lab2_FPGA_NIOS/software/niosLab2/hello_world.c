/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

//#include <stdio.h>
//
//int main()
//{
//  printf("Hello from Nios II!\n");
//
//  return 0;
//}

#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include <io.h> /* Leiutura e escrita no Avalon */

int delay(int n){
      unsigned int delay = 0 ;
      while(delay < n){
          delay++;
      }
}

int main(void){
  unsigned int led = 0;

  printf("Embarcados++ \n");

  while(1){
      if (led <= 5){
          IOWR_32DIRECT(PIO_0_BASE, 0, 0x01 << led++);
          usleep(50000);
      }
      else{
          led = 0;
      }
  };

  return 0;
}
