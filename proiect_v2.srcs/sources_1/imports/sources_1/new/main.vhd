----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2020 03:13:23 PM
-- Design Name: 
-- Module Name: main - Behavioral
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
 use IEEE.std_logic_arith.all;
 use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
  Port (
  clk:in std_logic;
  base: in std_logic_vector(15 downto 0);
  exponent: in std_logic_vector(7 downto 0);
  rst: in std_logic;
  rez_sqrt: out std_logic_vector (15 downto 0);
  rez_pow:out std_logic_vector(15 downto 0)
   );
end main;

architecture Behavioral of main is
signal a,q: std_logic_vector(15 downto 0):="0000000000000000";
signal term:std_logic;

signal root_finish: std_logic:='0';


begin



 
DUT1: entity WORK.putere_main port map
        (
        clk => clk,
        base => base(15 downto 8),
        exponent => exponent,
        rst => rst,
        rez_pow => rez_pow
        );
        
 DUT2: entity WORK.uc_radical
  port map(     
       clk =>clk,
       a => base,
       finish => root_finish,
       rst => rst,
       rez_sqrt => rez_sqrt
 );


end Behavioral;
