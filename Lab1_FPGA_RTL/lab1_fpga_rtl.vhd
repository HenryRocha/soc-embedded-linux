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
    SIGNAL switch_count : INTEGER RANGE 0 TO 10 := 0;
BEGIN
    -- The speed is a count of how many switches are enable.
    -- We count how many bits are '1' on the switches vector
    -- and assign that to the switch_count signal.
    PROCESS (fpga_switch)
        VARIABLE count : unsigned(3 DOWNTO 0) := "0000";
    BEGIN
        count := "0000";
        FOR i IN 0 TO 9 LOOP
            IF (fpga_switch(i) = '1') THEN
                count := count + 1;
            END IF;
        END LOOP;
        switch_count <= to_integer(unsigned(count));
    END PROCESS;

    PROCESS (fpga_clk_50)
        VARIABLE counter : INTEGER RANGE 0 TO 2000000000 := 0;
    BEGIN
        IF (rising_edge(fpga_clk_50)) THEN
            -- To change the speed the LEDs blink at change the value inside the if check.
            -- 50000000 ~ 1s
            IF (counter < 50000000 / (2 + switch_count)) THEN
                counter := counter + 1;
            ELSE
                blink <= NOT blink;
                counter := 0;
            END IF;
        END IF;
    END PROCESS;

    -- Make the last 3 LEDs blink.
    fpga_led_pio(9) <= blink;
    fpga_led_pio(8) <= blink;
    fpga_led_pio(7) <= blink;

    -- Make the first LED react to the first push button.
    fpga_led_pio(0) <= NOT fpga_push_btn(0);
END rtl;