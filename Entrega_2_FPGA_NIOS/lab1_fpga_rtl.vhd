LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Lab1_FPGA_RTL IS
    PORT (
        -- Gloabals
        fpga_clk_50 : IN std_logic;

        -- I/Os
        fpga_push_btn : IN std_logic_vector(3 DOWNTO 0);
        fpga_switch : IN std_logic_vector(9 DOWNTO 0);
        fpga_led_pio : OUT std_logic_vector(9 DOWNTO 0)
    );
END ENTITY Lab1_FPGA_RTL;

ARCHITECTURE rtl OF Lab1_FPGA_RTL IS
    SIGNAL blink : std_logic := '0';
    SIGNAL switch_count : INTEGER RANGE 0 TO 2000000000 := 0;
    SIGNAL pwm : std_logic := '0';
    SIGNAL pwm_count : INTEGER RANGE 0 TO 2000000000 := 0;
BEGIN
    -- How many times the LEDs will blink per second depends
    -- on the integer derived from the binary representation
    -- of the first 6 switches.
    -- 000001 - 1
    -- 001010 - 10

    -- The intensity of the LEDs depends on the integer derived
    -- from the binary representation of the last 4 switches.
    -- 0000 - 0 - Full brightness
    -- 0001 - 1 - Half brightness
    PROCESS (fpga_switch)
    BEGIN
        switch_count <= to_integer(unsigned(fpga_switch(5 DOWNTO 0)));
        pwm_count <= to_integer(unsigned(fpga_switch(9 DOWNTO 6)));
    END PROCESS;

    PROCESS (fpga_clk_50)
        VARIABLE counter : INTEGER RANGE 0 TO 2000000000 := 0;
    BEGIN
        IF (rising_edge(fpga_clk_50)) THEN
            -- Will only blink if there is a switch active.
            IF (switch_count > 0) THEN
                -- 50000000 ~ 1s
                IF (counter < 50000000 / switch_count) THEN
                    counter := counter + 1;
                ELSE
                    blink <= NOT blink;
                    counter := 0;
                END IF;
            ELSE
                blink <= '0';
            END IF;
        END IF;
    END PROCESS;

    PROCESS (fpga_clk_50)
        VARIABLE counter : INTEGER RANGE 0 TO 2000000000 := 0;
    BEGIN
        IF (rising_edge(fpga_clk_50)) THEN
            -- If no switch is on, full brightness.
            IF (pwm_count > 0) THEN
                -- Controls the intensity of the LEDs, if according
                -- to the last 4 switches.
                IF (counter < pwm_count) THEN
                    counter := counter + 1;
                    pwm <= '0';
                ELSE
                    pwm <= '1';
                    counter := 0;
                END IF;
            ELSE
                pwm <= '1';
            END IF;
        END IF;
    END PROCESS;

    -- Make the last 3 LEDs blink.
    fpga_led_pio(9) <= blink AND pwm;
    fpga_led_pio(8) <= blink AND pwm;
    fpga_led_pio(7) <= blink AND pwm;

    -- Make the first LED react to the first push button.
    fpga_led_pio(0) <= NOT fpga_push_btn(0);
END rtl;