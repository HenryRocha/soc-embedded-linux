LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Lab1_FPGA_RTL IS
    PORT (
        -- Gloabals
        fpga_clk_50 : IN STD_LOGIC;

        -- I/Os
        fpga_push_btn : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        fpga_switch   : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        fpga_led_pio  : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
        stepmotor_pio : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY Lab1_FPGA_RTL;

ARCHITECTURE rtl OF Lab1_FPGA_RTL IS
    COMPONENT niosLab2 IS
        PORT (
            clk_clk         : IN STD_LOGIC := 'X';                               -- clk
            leds_export     : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);                  -- export
            motor_motor     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);                  -- motor
            reset_reset_n   : IN STD_LOGIC                    := 'X';            -- reset_n
            switches_export : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS => 'X') -- export
        );
    END COMPONENT niosLab2;
BEGIN
    u0 : COMPONENT niosLab2 PORT MAP(
        clk_clk         => fpga_clk_50,              --      clk.clk
        leds_export     => fpga_led_pio(5 DOWNTO 0), --     leds.export
        motor_motor     => stepmotor_pio,            --    motor.motor
        reset_reset_n   => '1',                      --    reset.reset_n
        switches_export => fpga_switch(9 DOWNTO 0)   -- switches.export
    );
END rtl;