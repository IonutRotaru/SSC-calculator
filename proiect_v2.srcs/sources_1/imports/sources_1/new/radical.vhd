----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/23/2020 07:43:36 PM
-- Design Name: 
-- Module Name: radical - Behavioral
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

entity radical is
Port (
clk: in std_logic;
x2: in std_logic_vector(7 downto 0);
y2:in std_logic_vector(7 downto 0);
rez2: out std_logic;
xout: out std_logic_vector(7 downto 0)
 );
end radical;

architecture Behavioral of radical is
signal aux: std_logic_vector(7 downto 0):=(others =>'0');

begin

aux <= x2(6 downto 0) & '1';

process
begin
    
    
    if aux > y2 then 
    rez2 <= '0';
    xout <= x2(6 downto 0) & '0';
    else 
     rez2 <='1';
     xout <= x2(6 downto 0) & '1';
     end if; 
     wait;
end process;


end Behavioral;
