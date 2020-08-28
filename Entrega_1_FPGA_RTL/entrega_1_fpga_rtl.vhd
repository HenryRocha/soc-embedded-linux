LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY entrega_1_fpga_rtl IS
    PORT (
        -- Gloabals
        fpga_clk_50 : IN std_logic;

        -- I/Os
        stepmotor_en : IN std_logic;
        stepmotor_dir : IN std_logic;
        stepmotor_vel : IN std_logic_vector(1 DOWNTO 0);
        stepmotor_pio : OUT std_logic_vector(3 DOWNTO 0)
    );
END ENTITY entrega_1_fpga_rtl;

ARCHITECTURE rtl OF entrega_1_fpga_rtl IS
BEGIN
    motor : ENTITY work.stepmotor PORT MAP(
        clk => fpga_clk_50,
        en => stepmotor_en,
        dir => stepmotor_dir,
        vel => stepmotor_vel,
        phases => stepmotor_pio
        );
END rtl;