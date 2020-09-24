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

#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include <io.h> /* Leiutura e escrita no Avalon */
// Includes para a interrupcao
#include "altera_avalon_pio_regs.h"
#include <unistd.h>

// Variaveis globais
volatile int edge_capture, sw, vel;
volatile char on, dir;

int delay(int n)
{
    unsigned int delay = 0;
    while (delay < n)
    {
        delay++;
    }
}

/*******************************************************************
  * static void handle_button_interrupts( void* context, alt_u32 id)*
  *                                                                 *
  * Handle interrupts from the buttons.                             *
  * This interrupt event is triggered by a button/switch press.     *
  * This handler sets *context to the value read from the button    *
  * edge capture register.  The button edge capture register        *
  * is then cleared and normal program execution resumes.           *
  * The value stored in *context is used to control program flow    *
  * in the rest of this program's routines.                         *
  ******************************************************************/

void handle_button_interrupts(void *context, alt_u32 id)
{
    /* Cast context to edge_capture's type. It is important that this be
      * declared volatile to avoid unwanted compiler optimization.
      */
    volatile int *edge_capture_ptr = (volatile int *)context;
    /* Store the value in the Button's edge capture register in *context. */
    // Pega o valor que mudou do switch.
    // bit 0 -> 1
    // bit 1 -> 2
    // bit 2 -> 4
    // bit 3 -> 8
    *edge_capture_ptr = IORD_ALTERA_AVALON_PIO_EDGE_CAP(PIO_1_BASE);

    // Pega o valor numerico dos switches.
    sw = IORD_ALTERA_AVALON_PIO_DATA(PIO_1_BASE);

    // Pega o bit 0 dos sws.
    char swOn = (sw >> 0) & 1;
    on = swOn;
    printf("On %d\n", swOn);

    // Pega o bit 1 dos sws.
    int swDir = (sw >> 1) & 1;
    dir = swDir;
    printf("Dir %d\n", swDir);

    // Usa dos bits 2 e 3 para calcular a velocidade.
    vel = ((sw >> 2) & 1) * 1 + ((sw >> 3) & 1) * 2;
    printf("Vel %d\n", vel);

    /* Reset the Button's edge capture register. */
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_1_BASE, 0);
}

/* Initialize the pio. */
void init_pio()
{
    /* Recast the edge_capture pointer to match the alt_irq_register() function
      * prototype. */
    void *edge_capture_ptr = (void *)&edge_capture;
    /* Enable first four interrupts. */
    IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PIO_1_BASE, 0xf);
    /* Reset the edge capture register. */
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_1_BASE, 0x0);
    /* Register the interrupt handler. */
    alt_irq_register(PIO_1_IRQ, edge_capture_ptr,
                     handle_button_interrupts);
}

int main(void)
{
    unsigned int phases = 0;
    int sleep = 100000;
    on = 0;
    dir = 0;
    unsigned int led = 0;

    printf("Embarcados+++ \n");

    // Inicializa a interrupcao
    init_pio();

    while (1)
    {
        if (on)
        {
            if (phases <= 5)
            {
                if (dir)
                    IOWR_32DIRECT(PIO_2_BASE, 0, 0x08 >> phases++);
                else
                    IOWR_32DIRECT(PIO_2_BASE, 0, 0x01 << phases++);
                usleep(sleep / (vel + 1));
            }
            else
            {
                phases = 0;
            }

            if (led <= 5)
            {
                if (dir)
                    IOWR_32DIRECT(PIO_0_BASE, 0, 0x08 >> led++);
                else
                    IOWR_32DIRECT(PIO_0_BASE, 0, 0x01 << led++);
                usleep(sleep / (vel + 1));
            }
            else
            {
                led = 0;
            }
        }
    };

    return 0;
}
