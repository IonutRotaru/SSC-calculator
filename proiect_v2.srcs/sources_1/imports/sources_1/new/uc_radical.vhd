----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2020 11:05:39 PM
-- Design Name: 
-- Module Name: uc - Behavioral
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

entity uc_radical is
  Port (
  clk: in std_logic;
  a:in std_logic_vector(15 downto 0); 
  finish: out std_logic;
  rst:in std_logic;
  rez_sqrt: out std_logic_vector(15 downto 0));
end uc_radical;

architecture Behavioral of uc_radical is

type TIP_STARE is (start1,calc1,calc2,calc_an,calc_y,comp,stop);
signal Stare : TIP_STARE:=start1; 
signal c:integer:=8; --8 perechi de cate 2 biti din cei 16  ai numarului a
signal dif: std_logic_vector(15 downto 0):="0000000000000000"; -- diferenta din algoritmul de radical
signal rez_aux: std_logic_vector(15 downto 0):="0000000000000000"; -- rezultat intermediar care la final reprezinta rezultatul radicalului
signal pair:std_logic_vector(1 downto 0):="00"; -- pereche de 2 biti care coboara din numarul a 
signal x_new: std_logic_vector(15 downto 0):="0000000000000000"; -- numarul dupa dublarea untimului bit
signal b_1_or_0:  std_logic:= '0';  --bitul cel mai putin semnificativ din rezultatul intermediar
signal y_new: std_logic_vector(15 downto 0):="0000000000000000";
signal x_aux:   std_logic_vector(15 downto 0):="0000000000000000"; -- numarul care primeste un 0 sau un 1 la final

signal last_number: std_logic_vector(15 downto 0) := a;

begin

rez_sqrt <= rez_aux;
        
proc1: process (clk)
begin
 
 if RISING_EDGE (Clk) then
   if(rst = '1') then 
      
      Stare <= Start1;
        
   else 
   case Stare is
     when Start1 => 
                    rez_aux <= "0000000000000000";              -- initializare semnale
                    c <= 8;
                    x_new <= "0000000000000000"; 
                    y_new <= "00000000000000" &  a(15 downto 14);
                    finish <='0';
                    Stare <= calc2;
                    x_aux <= "0000000000000000";
                    b_1_or_0 <= '0';
                    y_new <= "0000000000000000";
     
     when calc1 =>  
                    if x_new(14 downto 0) & '1' > y_new then -- calcularea bitului adaugat la inceput 
                        b_1_or_0 <= '0';
                        x_aux <= x_new(14 downto 0) & '0';
                    else 
                        b_1_or_0 <='1';
                        x_aux <= x_new(14 downto 0) & '1';
                    end if; 
                     
                    Stare<=comp;
                    
     when calc2 => 
                   if x_aux(0) = '1' then   -- calcularea numarului dupa dublarea ultimei cifre si calcularea diferentei
                      x_new <= x_aux + 1;
                      dif <= y_new - x_aux;
                   else 
                      dif <= y_new;
                   end if;
                      Stare <= calc_an;
                      
      when comp =>   
                    rez_aux <= rez_aux(14 downto 0) & b_1_or_0; -- actualizare rezultat intermediar
                    
                     if c = 0 then -- daca s-au verificat toate cele 8 perechi, algoritmul se opreste
                        Stare <= stop; 
                     else Stare <= calc2;
                        end if;
               
     when calc_an =>            
                    if c = 0 then 
                        Stare <= stop ;
                    else 
                        pair <= a(2*c - 1 downto 2*c-2); --  se trece la urmatoarea pereche de 2 biti
                        Stare <= calc_y;
                        c <= c-1;                        -- se decrementeaza contorul
                    end if;
                    
     when calc_y => y_new <= dif(13 downto 0) & pair; -- se coboara si se asigneaza nowa pereche de 2 biti
                    Stare <= calc1;
                    
     when stop => --if  rst = '1' then Stare <= Start1; else
                  --Stare <= Stop;
                  --finish <= '1';
                  --end if;
                  if a = last_number then -- daca numarul pentru care se cere radacina e acelasi, atunci nu se  reia algoritmul
                     Stare <= stop;
                  else
                    last_number <= a;
                    Stare <= Start1;
                  end if;
   
    
     
     
   
   end case;
 end if;
 end if;
end process;



end Behavioral;
