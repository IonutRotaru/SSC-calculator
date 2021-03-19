----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/23/2020 07:53:34 PM
-- Design Name: 
-- Module Name: radical_main - Behavioral
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

entity radical_main is
  Port ( 
  
  clk: in std_logic;
  a: in std_logic_vector (15 downto 0);
  root: out std_logic_vector( 15 downto 0);
  rst:in std_logic;
  finish: out std_logic
  );
end radical_main;

architecture Behavioral of radical_main is

begin


 e3: entity WORK.uc_radical
  port map(
      
      clk =>clk,
      a => a,
      finish => finish,
      rst => rst,
      rez_sqrt => root
 );

end Behavioral;
