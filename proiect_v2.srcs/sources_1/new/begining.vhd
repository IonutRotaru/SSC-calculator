----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2020 11:55:53 AM
-- Design Name: 
-- Module Name: begining - Behavioral
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

entity begining is
Port (clk: in std_logic; 
sw: in std_logic_vector(15 downto 0);
btn:in std_logic_vector(4 downto 0);
cat: out std_logic_vector(6 downto 0);
an: out std_logic_vector(3 downto 0));
end begining;

architecture Behavioral of begining is
signal rez: std_logic_vector(7 downto 0) :="00000000";
signal rst: std_logic:='0';
signal data: std_logic_vector(15 downto 0) := sw;
signal rez_inmultire: std_logic_vector(15 downto 0):="0000000000000000";
signal afiseaza_putere,afiseaza_radical,afiseaza_argumente: std_logic:='0';
begin

 DUT: entity WORK.main port map
        (
        clk => clk,
        xx => sw(7 downto 0),
        yyy => sw(15 downto 8),
        rst => rst,
        rez => rez,
        rez_inmultire => rez_inmultire
      
        
        );
        
   
 E2: entity WORK.display_7seg port map (
 clk => clk,
 digit3  => data(15 downto 12),
 digit2 => data(11 downto 8),
 digit1 => data(7 downto 4) ,
 digit0 => data(3 downto 0),
 cat => cat,
 an => an
 ); 
 
 E3: entity WORK.debounce port map (
 clk => clk,
 rst => btn(0),
 din => btn(1),
 qout => rst
 
 );
  E4: entity WORK.debounce port map (
 clk => clk,
 rst => btn(0),
 din => btn(2),
 qout => afiseaza_putere
 
 );
  E5: entity WORK.debounce port map (
 clk => clk,
 rst => btn(0),
 din => btn(3),
 qout => afiseaza_radical
 
 );
 E6: entity WORK.debounce port map (
 clk => clk,
 rst => btn(0),
 din => btn(4),
 qout => afiseaza_argumente
 
 );
 
   process(clk)
   begin
   
   if clk'event and clk ='1' then
        if afiseaza_radical ='1' then
            data <= "00000000" & rez;
        elsif afiseaza_putere ='1' then
            data<=  rez_inmultire;
        elsif afiseaza_argumente ='1' then
            data <= sw;
        end if;
   end if;
   
   end process;

end Behavioral;
