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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uc is
 generic (n: natural:=16);
  Port (
  clk: in std_logic;
  rst: in std_logic;
  start: in std_logic;
  q0: in std_logic;
  q_minus_1:in std_logic;
  rsta:out std_logic;
  loada:out std_logic;
  subb:out std_logic;
  loadb:out std_logic;
  shraq: out std_logic;
  loadq: out std_logic;
  rstqm:out std_logic;
  
  term:out std_logic );
end uc;

architecture Behavioral of uc is

type TIP_STARE is (idle, init, q0q1, dif,sum,shiftare,testare,stop);
signal Stare : TIP_STARE:=idle; 
signal c:integer:=n;


begin
proc1: process (clk)
begin
 
 if RISING_EDGE (Clk) then
   if(rst = '1') then
      Stare <= idle;
   else 
   case Stare is
     when idle => if start = '1' then Stare <=init; end if;
     when init => Stare <= q0q1;c<=n;
     when q0q1 => if q0='1' and q_minus_1 = '0' then 
                        Stare <=dif; 
                  elsif q0='0' and q_minus_1 = '1' then
                    Stare <= sum ;
                    else Stare <= shiftare;
                    end if; 
     when dif => Stare <= shiftare;
     when sum => Stare <= shiftare;
     when shiftare => Stare <= testare;c <= c-1;
     when testare => if c = 0 then 
                        Stare <= stop; 
                        else Stare <= q0q1;
                        end if;
     when stop => if( rst ='1')then Stare <= idle; end if;
   end case;
 end if;
 end if;
end process;


 proc2: process (Stare)
begin
 case Stare is 
  when idle => subb<='0';loadb<='0';rsta <='0';loada<='1';
                 shraq <='0'; loadq<='0';rstqm <='0'; term <='0';
  when init => subb<='0';loadb<='1';rsta <='1';loada<='0';
                 shraq <='0'; loadq<='1';rstqm <='1'; term <='0';
  when q0q1 =>  
                subb<='0';loadb<='0';rsta <='0';loada<='0';
                 shraq <='0'; loadq<='0';rstqm <='0'; term <='0';
  when dif =>   subb<='1';loadb<='0';rsta <='0';loada<='1';
                 shraq <='0'; loadq<='0';rstqm <='0'; term <='0';
  when sum =>   subb<='0';loadb<='0';rsta <='0';loada<='1';
                 shraq <='0'; loadq<='0';rstqm <='0'; term <='0';
  when shiftare =>subb<='0';loadb<='0';rsta <='0';loada<='0';
                 shraq <='1'; loadq<='0';rstqm <='0'; term <='0';
  when testare =>  subb<='0';loadb<='0';rsta <='0';loada<='0';
                 shraq <='0'; loadq<='0';rstqm <='0'; term <='0';
  when stop =>subb<='0';loadb<='0';rsta <='0';loada<='0';
                 shraq <='0'; loadq<='0';rstqm <='0'; term <='1';
 end case;
end process;

end Behavioral;
