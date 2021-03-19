----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2020 10:19:03 PM
-- Design Name: 
-- Module Name: srrn - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity srrn is
 generic (n: natural:=16);

  Port ( clk: in std_logic;
         d: in std_logic_vector(n-1 downto 0); 
         sri: in std_logic;
         load: in std_logic;
         rst: in std_logic;
         ce: in std_logic;
         q: out std_logic_vector(n-1 downto 0));
end srrn;

architecture Behavioral of srrn is
signal q_aux: std_logic_vector(n-1 downto 0);
begin

process(clk)
begin
    if clk'event and clk = '1' then 
      if rst = '1' then 
         q_aux <= (others => '0');
      elsif load = '1' then 
         q_aux <= d;
         elsif ce = '1' then
         q_aux <= sri & q_aux(n-1 downto 1);
         end if;
    end if;     
end process;

q <=q_aux;

end Behavioral;
