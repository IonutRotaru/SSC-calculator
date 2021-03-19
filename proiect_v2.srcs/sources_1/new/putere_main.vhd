----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/12/2020 02:08:25 PM
-- Design Name: 
-- Module Name: putere_main - Behavioral
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

entity putere_main is
  Port (
        Clk: in std_logic;
        base: in std_logic_vector(7 downto 0);
        exponent: in std_logic_vector(7 downto 0);
        rst: in std_logic;
        rez_pow: out std_logic_vector(15 downto 0)
  
   );
end putere_main;

architecture Behavioral of putere_main is

signal start,rst_booth: std_logic:='0';
signal x: std_logic_vector(15 downto 0) := "00000000" & base;
signal y: std_logic_vector(15 downto 0) := "00000000" & base;
signal a,q: std_logic_vector(15 downto 0):="0000000000000000";
signal term:std_logic:='0';
signal aq:std_logic_vector(31 downto 0):= "0000000000000000" & x;
signal count: std_logic_vector(7 downto 0):= exponent;

type TIP_STARE is (idle,start_booth,wait_rez,decrement,comp,stop);

signal Stare : TIP_STARE:=idle; 
signal last_base : std_logic_vector(7 downto 0) := base; 
signal last_exponent : std_logic_vector(7 downto 0) := exponent; 

begin

DUT: entity WORK.inmultireBooth port map
        (
  clk => clk,
  rst => rst_booth,
  start => start,
  x =>x,
  y => y,
  a =>a,
  q =>q,
  term =>term
      );
      
 
start <= '1' when Stare = start_booth else '0';     
rst_booth <= '1' when Stare = idle or Stare = comp else '0';

proc1: process (clk) -- automat de stari in care baza se inmulteste cu ea insasi de (exponent - 1) ori
begin
 
 if RISING_EDGE (Clk) then
   if(rst = '1') then
       Stare <= idle;
   else 
   
   case Stare is
    
    when idle => x <= "00000000" & base; -- initializare argumente pentru inmultitorul Booth
                 y <= "00000000" & base;
                 aq <= "0000000000000000" & x;
                 count <= exponent;
                 Stare <= start_booth;
    
    when start_booth => Stare <= wait_rez;  -- se da semnalul de incepere a algoritmului booth
    
    when wait_rez => if term ='1' then  -- se asteapta terminarea algoritmului both
                        aq <= a & q;
                        Stare <= decrement;
                     end if;
                     
    when decrement => count <= count - 1; -- se decrementeaza contorul pentru numarul de inmultiri repetate
                      Stare <= comp;
                      y <= aq(15 downto 0);
    when comp => if count = "00000001" then -- se verifica terminarea numarului de inmultiri repetate
                    Stare <= stop;
                 else
                    Stare <= start_booth;
                 end if;
    when stop =>   
                    if exponent = "00000001" then       -- caz spexial pentru x^1
                        rez_pow <= "00000000" & base;
                   
                    elsif exponent = "00000000" then    -- caz special pentru x^0
                        rez_pow <= "0000000000000001";
                    
                    else
                        rez_pow <= aq(15 downto 0);     -- asignare rezultat ridicare la putere
                    end if;
                    
                    if last_base = base and last_exponent = exponent then -- daca argumentele ridicarii la putere nu se schimba
                        Stare <= stop;                                    -- atunci nu se reia algoritmul pentru a ramane rezultatul in continuare afisat
                    else
                     Stare <= idle;
                     last_base <= base;
                     last_exponent <= exponent; 
                    end if;
                   --if rst ='1' then
                    --Stare <= idle;
                    
                  --end if;
    
    
   end case;
   end if;
   end if;
 end process;

end Behavioral;
