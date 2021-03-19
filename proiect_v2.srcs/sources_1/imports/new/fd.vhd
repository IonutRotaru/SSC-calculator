----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2020 10:10:35 PM
-- Design Name: 
-- Module Name: fd - Behavioral
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

entity fd is
 Port (
 clk : in std_logic;
 d : in std_logic;
 ce : in std_logic; 
 rst : in std_logic; 
 q : out std_logic
 
  );
end fd;

architecture Behavioral of fd is

begin

process(clk)
begin
    if clk'event and clk = '1' then    
      if rst = '1' then 
        q <= '0';
       elsif ce = '1' then 
          q <= d;
        end if;
     end if; 
end process;

end Behavioral;
