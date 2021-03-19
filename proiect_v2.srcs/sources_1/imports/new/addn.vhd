----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2020 10:38:09 PM
-- Design Name: 
-- Module Name: addn - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity addn is
generic (n: natural:=16);
Port (
x: in std_logic_vector(n-1 downto 0);
y: in std_logic_vector(n-1 downto 0);
tin: in std_logic;
s: out std_logic_vector(n-1 downto 0);
tout: out std_logic;
ovf: out std_logic
 );
end addn;

architecture Behavioral of addn is

signal T: std_logic_vector(n downto 0):= (others =>'0');

begin

T(0) <= tin;
 e: for i in 0 to n-1 generate
      s(i) <= x(i) xor y(i) xor T(i);
      T(i+1) <= (x(i) and y(i)) or ((x(i) or y(i)) and T(i));
  end generate;
 tout<=t(n);
 ovf<=t(n-1) xor t(n);

end Behavioral;
