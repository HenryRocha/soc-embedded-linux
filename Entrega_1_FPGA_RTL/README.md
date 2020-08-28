# Entrega 1 - Controlando um motor de passos

## Descrição da entrega

Desenvolver um IP Core (Intellectual Property Core) dedicado para o controle de um motor de passos. Esse componente deve controlar as quatro fases de um motor de passos de forma a girar o motor nos dois sentidos e com algumas velocidades diferentes.

## Descrição da implementação

TODO

## Materiais

Placa: FPGA DE10-Standard
Motor: Rohs Step Motor 28BYJ-48

## Pinos usados e sua descrição

- Switch SW0: Liga ou desliga a rotação do motor.
- Switch SW1: Controla a direção de rotação do motor.
- Switch SW2 e SW3: Controlam a velocidade do motor. Configuração `00` é a mais lenta enquanto `11` é a mais rápida.

## Rúbrica

Rubrica
- A
    - [ ] Aplica uma curva de aceleração na velocidade.
- B
    - [ ] Possuir número de passos a serem executados.
- C
    - [X] Aciona o motor de passos e possui um sinal de:
        - [X] EN (que liga e desliga o motor)
        - [ ] DIR (que controla a direção na qual o motor gira)
        - [X] VEL (quatro velocidades de rotação)
- D
    - [ ] Entregou o tutorial
- I
    - [ ] Não entregou nada
