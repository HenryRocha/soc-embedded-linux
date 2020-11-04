LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY LAB2_FPGA_NIOS IS
  PORT (
    -- Gloabals
    fpga_clk_50 : IN STD_LOGIC; -- clock.clk

    -- I/Os
    fpga_led_pio : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    fpga_switch  : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
END ENTITY LAB2_FPGA_NIOS;

ARCHITECTURE rtl OF LAB2_FPGA_NIOS IS
  COMPONENT niosLab2 IS
    PORT (
      clk_clk       : IN STD_LOGIC := 'X';                               -- clk
      reset_reset_n : IN STD_LOGIC := 'X';                               -- reset_n
      leds_leds     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);                  -- leds
      buts_export   : IN STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => 'X') -- export
    );
  END COMPONENT niosLab2;
BEGIN
  u0 : COMPONENT niosLab2 PORT MAP(
    clk_clk       => fpga_clk_50,  --  clk.clk
    reset_reset_n => '1',          --  reset.reset_n
    leds_leds     => fpga_led_pio, --  leds.leds
    buts_export   => fpga_switch   --  buts.export
  );
END rtl;