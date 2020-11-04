#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include <io.h> /* Leiutura e escrita no Avalon */
#include "altera_avalon_pio_regs.h"
#include "motor.h"
#include <unistd.h>
#include "sys/alt_irq.h"


int main()
{
  printf("Pegando ponteiro\n");
  unsigned int *p_motor = (unsigned int *) PERIPHERAL_MOTOR_0_BASE;
  char dir = 1;

  printf("Iniciando motor\n");
  motor_init(p_motor);
  motor_dir(p_motor + 1, dir);

  printf("Ligando motor\n");
  motor_en(p_motor);

  printf("Motor em vel 0\n");
  motor_vel(p_motor + 2, 0);
  printf("Dormindo por 10s\n");
  usleep(10000000);

  printf("Motor em vel 1\n");
  motor_vel(p_motor + 2, 1);
  printf("Dormindo por 10s\n");
  usleep(10000000);

  printf("Motor em vel 3\n");
  motor_vel(p_motor + 2, 3);
  printf("Dormindo por 10s\n");
  usleep(10000000);

  printf("Parando o motor\n");
  motor_halt(p_motor);
  printf("Encerrando\n");
  usleep(20000000);
  printf("Parou de girar\n");

//  while(1) {
//    dir =! dir;
//    usleep(7000000);
//    usleep(7000000);
//    motor_dir(p_motor + 1, dir);
//    printf("-------\n");
//  }

  return 0;
}
