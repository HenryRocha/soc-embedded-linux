#include <stdio.h>
#include <io.h>


void motor_init(unsigned int *p_motor) {
  // Recebe um ponteiro para o endereco do motor.
  // Inicializa o motor.
  IOWR_32DIRECT(p_motor, 0, 1);
}

void motor_halt(unsigned int *p_motor) {
  // Recebe um ponteiro para o endereco do motor.
  // Para o motor.
  IOWR_32DIRECT(p_motor, 0, 0);
}

void motor_en(unsigned int *p_motor) {
  // Recebe um ponteiro para o endereco do motor.
  // Liga o motor.
  IOWR_32DIRECT(p_motor, 0, 1);
}

void motor_dir(unsigned int *p_motor, int dir) {
  // Recebe um ponteiro para o endereco do motor e a direcao desejada.
  // Muda a direcao do motor.
  IOWR_32DIRECT(p_motor, 0, dir);
}

void motor_vel(unsigned int *p_motor, int vel){
  // Recebe um ponteiro para o endereco do motor e a velocidade desejada.
  // Muda a velocidade do motor.
  IOWR_32DIRECT(p_motor, 0, vel);
}
