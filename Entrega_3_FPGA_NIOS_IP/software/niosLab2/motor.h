#include <stdio.h>
#include <io.h>


void motor_init(unsigned int *p_motor) {
  // Recebe um ponteiro para o endereco do motor.
  // Inicializa o motor.
  printf("Valor lido EN before: %d\n", IORD_32DIRECT(p_motor, 0));
  printf("Escrevendo no EN\n");
  IOWR_32DIRECT(p_motor, 0, 1);
  printf("Valor lido EN after: %d\n", IORD_32DIRECT(p_motor, 0));
}

void motor_halt(unsigned int *p_motor) {
  // Recebe um ponteiro para o endereco do motor.
  // Para o motor.
  printf("Valor lido EN before: %d\n", IORD_32DIRECT(p_motor, 0));
  printf("Escrevendo no EN\n");
  IOWR_32DIRECT(p_motor, 0, 0);
  printf("Valor lido EN after: %d\n", IORD_32DIRECT(p_motor, 0));
}

void motor_en(unsigned int *p_motor) {
  // Recebe um ponteiro para o endereco do motor.
  // Liga o motor.
  printf("Valor lido EN before: %d\n", IORD_32DIRECT(p_motor, 0));
  printf("Escrevendo no EN\n");
  IOWR_32DIRECT(p_motor, 0, 1);
  printf("Valor lido EN after: %d\n", IORD_32DIRECT(p_motor, 0));
}

void motor_dir(unsigned int *p_motor, int dir) {
  // Recebe um ponteiro para o endereco do motor e a direcao desejada.
  // Muda a direcao do motor.
  printf("Valor lido DIR before: %d\n", IORD_32DIRECT(p_motor, 0));
  printf("Escrevendo no DIR\n");
  IOWR_32DIRECT(p_motor, 0, dir);
  printf("Valor lido DIR after: %d\n", IORD_32DIRECT(p_motor, 0));
}

void motor_vel(unsigned int *p_motor, int vel){
  // Recebe um ponteiro para o endereco do motor e a velocidade desejada.
  // Muda a velocidade do motor.
  printf("Valor lido VEL before: %d\n", IORD_32DIRECT(p_motor, 0));
  printf("Escrevendo no VEL\n");
  IOWR_32DIRECT(p_motor, 0, vel);
  printf("Valor lido VEL after: %d\n", IORD_32DIRECT(p_motor, 0));
}
