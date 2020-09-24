# Entrega 1 - Controlando um motor de passos

## Descrição da entrega
Desenvolver o controle de um motor de passos usando o NIOS 2 (Soft Processor). Esse componente deve controlar as quatro fases de um motor de passos de forma a girar o motor nos dois sentidos e com algumas velocidades diferentes.

## Descrição da implementação

TODO

## Materiais

- Placa: FPGA DE10-Standard
- Motor: Rohs Step Motor 28BYJ-48

## Pinos usados e sua descrição

- Switch SW0: Liga ou desliga a rotação do motor.
- Switch SW1: Controla a direção de rotação do motor.
- Switch SW2 e SW3: Controlam a velocidade do motor. Configuração `00` é a mais lenta enquanto `11` é a mais rápida.

## Rúbrica

Rubrica

- A
  - [ ] Insira um RTOS no NIOS para fazer o controle da aplicação
  - Ou
  - [ ] Curva de aceleração no motor
- B
  - [X] Implementar VEL no SWx
  - [X] Interrupção na leitura do botão
- C
  - [X] Memória de dados separada da de programa
  - [X] JTAG gerando interrupção.
  - [X] PIO dedicado a ler botões (SWx) e controlar EN e DIR
- D
  - [X] Entregou somente tutorial
- I
  - [ ] Não entregou nada

