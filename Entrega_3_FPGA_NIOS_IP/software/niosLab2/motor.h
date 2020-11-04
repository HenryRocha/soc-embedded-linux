#include <stdio.h>
#include <io.h>


void motor_init(unsigned int *p_motor) {
  // Recebe um ponteiro para o endereco do motor.
  // Inicializa o motor.
  printf("Motor init: %d\n", *(p_motor));
  *(p_motor) = 0x0001;
  printf("Motor init After: %d\n", *(p_motor));
  printf("Valor lido EN: %d\n", IORD_32DIRECT(p_motor, 0));
}

void motor_halt(unsigned int *p_motor) {
  // Recebe um ponteiro para o endereco do motor.
  // Para o motor.
  printf("Motor Halt: %d\n", *(p_motor));
  *(p_motor) = 0x0000;
  printf("Motor Halt After: %d\n", *(p_motor));
  printf("Valor lido EN: %d\n", IORD_32DIRECT(p_motor, 0));
}

void motor_en(unsigned int *p_motor) {
  // Recebe um ponteiro para o endereco do motor.
  // Liga o motor.
  printf("Motor Enable: %d\n", *(p_motor));
  *(p_motor) = 0x0001;
  printf("Motor Enable After: %d\n", *(p_motor));
  printf("Valor lido EN: %d\n", IORD_32DIRECT(p_motor, 0));
}

void motor_dir(unsigned int *p_motor, int dir) {
  // Recebe um ponteiro para o endereco do motor e a direcao desejada.
  // Muda a direcao do motor.
  printf("Motor Dir: %d\n", *(p_motor));
  *(p_motor) = dir;
  printf("Motor Dir After: %d\n", *(p_motor));
  printf("Valor lido DIR: %d\n", IORD_32DIRECT(p_motor, 0));
}

void motor_vel(unsigned int *p_motor, int vel){
  // Recebe um ponteiro para o endereco do motor e a velocidade desejada.
  // Muda a velocidade do motor.
  printf("Motor Vel: %d\n", *(p_motor));
  *(p_motor) = vel;
  printf("Motor Vel After: %d\n", *(p_motor));
  printf("Valor lido VEL: %d\n", IORD_32DIRECT(p_motor, 0));
}
