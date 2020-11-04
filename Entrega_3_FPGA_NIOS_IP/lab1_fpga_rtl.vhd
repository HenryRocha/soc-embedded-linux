LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Lab1_FPGA_RTL IS
    PORT
    (
        -- Gloabals
        fpga_clk_50 : IN std_logic;

        -- I/Os
        fpga_push_btn : IN std_logic_vector(3 DOWNTO 0);
        fpga_switch   : IN std_logic_vector(9 DOWNTO 0);
        fpga_led_pio  : OUT std_logic_vector(9 DOWNTO 0);
        stepmotor_pio : OUT std_logic_vector(3 DOWNTO 0)
    );
END ENTITY Lab1_FPGA_RTL;

ARCHITECTURE rtl OF Lab1_FPGA_RTL IS
    COMPONENT niosLab2 IS
        PORT
        (
            clk_clk         : IN std_logic := 'X';                                -- clk
            leds_export     : OUT std_logic_vector(5 DOWNTO 0);                   -- export
            reset_reset_n   : IN std_logic                    := 'X';             -- reset_n
            switches_export : IN std_logic_vector(9 DOWNTO 0) := (OTHERS => 'X'); -- export
            motor_export    : OUT std_logic_vector(3 DOWNTO 0)                    -- export
        );
    END COMPONENT niosLab2;
BEGIN
    u0 : COMPONENT niosLab2 PORT MAP
    (
        clk_clk         => fpga_clk_50,              --    clk.clk
        leds_export     => fpga_led_pio(5 DOWNTO 0), --    leds.export
        reset_reset_n   => '1',                      --    reset.reset_n
        switches_export => fpga_switch,              --    switches.export
        motor_export    => stepmotor_pio             --    motor.export
    );
END rtl;