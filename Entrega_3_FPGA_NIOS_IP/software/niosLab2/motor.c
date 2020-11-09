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

  while (1) {
    printf("Ligando motor\n");
    motor_en(p_motor);
    
    printf("Configurando a dir do motor %c\n", dir);
    motor_dir(p_motor + 1, dir);

    printf("Motor em VEL 1 e dormindo por 5s\n");
    motor_vel(p_motor + 2, 1);
    usleep(3000000);

    printf("Motor em VEL 3 e dormindo por 5s\n");
    motor_vel(p_motor + 2, 3);
    usleep(3000000);

    printf("Parando o motor\n");
    motor_halt(p_motor);
    usleep(1000000);

    printf("Invertendo dir\n");
    dir = !dir;
  }

  return 0;
}
