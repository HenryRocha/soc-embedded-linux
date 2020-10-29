# Entrega 1 - Controlando um motor de passos

## Descrição da entrega

O objetivo dessa entrega é automatizarmos a compilação e deploy de novos programas para o target. 
Para isso, teremos que criar um Makefile que deve ser capaz de compilar e fazer o deploy de programa.

## Descrição da implementação

TODO

## Pinos usados e sua descrição

- `make scp`: compila e transfere o programa para a placa.
- `make run`: compila, transfere e roda o programa.
- `make gdb`: compila, transfere e roda o programa pelo gdb server.

## Rúbrica

- A
  - [ ] Debuga um programar no target (via gdbserver)
- B
  - [X] Via Makefile consegue executar o binário no target
        - make run / make deploy
- C
  - [X] Criou um Makefile que compila o código e faz o deploy para o target de um programa
        - make deploy
- D
  - [X] Entregou somente os tutoriais
- I
  - [ ] Não entregou nada
