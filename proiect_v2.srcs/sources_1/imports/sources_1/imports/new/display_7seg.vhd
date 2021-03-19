----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2020 04:16:31 PM
-- Design Name: 
-- Module Name: SSD - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display_7seg is
    Port ( clk : in STD_LOGIC;
           digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end display_7seg;

architecture Behavioral of display_7seg is
signal cnt : std_logic_vector(15 downto 0);
signal mux1 : std_logic_vector(3 downto 0);


begin

process(clk)
begin
if (clk'event and clk='1') then 
cnt<=cnt+1;
end if;
end process;

process(cnt(15 downto 14))
begin
case cnt(15 downto 14) is
when "00" => mux1<=digit0;
when "01" => mux1<=digit1;
when "10" => mux1<=digit2;
when "11" => mux1<=digit3;
end case;
end process;

process(cnt(15 downto 14))
begin
case cnt(15 downto 14) is
when "00" => an<="1110";
when "01" => an<="1101";
when "10" => an<="1011";
when "11" => an<="0111";
end case;
end process;

process(mux1)
begin
case mux1 is
when "0000" => cat<="1000000";
when "0001" => cat<="1111001";
when "0010" => cat<="0100100";
when "0011" => cat<="0110000";
when "0100" => cat<="0011001";
when "0101" => cat<="0010010";
when "0110" => cat<="0000010";
when "0111" => cat<="1111000";
when "1000" => cat<="0000000";
when "1001" => cat<= "0010000";
when "1010" => cat<=  "0001000";
when "1011" => cat<=  "0000011";
when "1100" => cat<="1000110"; 
when "1101" => cat<= "0100001";
when "1110" => cat<= "0000110";
when "1111" => cat<= "0001110";
end case;
end process;


end Behavioral;
