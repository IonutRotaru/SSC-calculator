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

entity beginning is
Port (clk: in std_logic; 
sw: in std_logic_vector(15 downto 0);
btn:in std_logic_vector(4 downto 0);
cat: out std_logic_vector(6 downto 0);
an: out std_logic_vector(3 downto 0));
end beginning;

architecture Behavioral of beginning is
signal rez_sqrt: std_logic_vector(15 downto 0) :="0000000000000000";
signal rst: std_logic:='0';
signal data: std_logic_vector(15 downto 0) := sw;
signal rez_pow: std_logic_vector(15 downto 0):="0000000000000000";
signal display_pow,display_sqrt,display_arguments: std_logic:='0';
signal what_to_display: integer :=0;
begin

 DUT: entity WORK.main port map
        (
        clk => clk,
        base => sw(15 downto 0),
        exponent => sw(7 downto 0),
        rst => rst,
        rez_sqrt => rez_sqrt,
        rez_pow => rez_pow
      
        
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
 qout => display_pow
 
 );
  E5: entity WORK.debounce port map (
 clk => clk,
 rst => btn(0),
 din => btn(3),
 qout => display_sqrt
 
 );
 E6: entity WORK.debounce port map (
 clk => clk,
 rst => btn(0),
 din => btn(4),
 qout => display_arguments
 
 );
 
 process(clk) -- in functie de butonul apasat, pe afisor vor fi fie argumentele pentru ridicare la putere/radical, fie rezultatul ridicarii la putere/radicalului
   begin
   if clk'event and clk ='1' then
        
      if display_sqrt ='1' then
            what_to_display <= 1;
        elsif display_pow ='1' then
            what_to_display <= 2;
        elsif display_arguments ='1' then
            what_to_display <= 0;
        end if;
   end if;
   end process;
   
    process(clk)
   begin
   if clk'event and clk ='1' then
       if what_to_display = 0 then 
            data <= sw;
       elsif what_to_display = 1 then
            data <= rez_sqrt;
       else data <= rez_pow;
       end if; 
   end if;
   
   end process;
 
  

end Behavioral;
