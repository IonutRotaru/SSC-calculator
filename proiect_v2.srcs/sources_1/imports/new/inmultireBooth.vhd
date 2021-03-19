----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2020 11:11:43 AM
-- Design Name: 
-- Module Name: inmultireBooth - Behavioral
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

entity inmultireBooth is
generic (n: natural:=16);
  Port (
  clk: in std_logic;
  rst: in std_logic;
  start: in std_logic;
  x:in std_logic_vector(n-1 downto 0);
  y: in std_logic_vector(n-1 downto 0);
  a: out std_logic_vector( n-1 downto 0);
  q: out std_logic_vector(n-1 downto 0);
  term: out std_logic
  
   );
end inmultireBooth;

architecture Behavioral of inmultireBooth is

signal rsta:std_logic :='0';
signal loada:std_logic :='0';
signal subb:std_logic :='0';
signal loadb:std_logic :='0';
signal shraq:std_logic :='0';

signal loadq:std_logic :='0';
signal rstqm:std_logic :='0';
signal tout:std_logic :='0';
signal b: std_logic_vector(n-1 downto 0):="0000000000000000";

signal suma: std_logic_vector(n-1 downto 0):="0000000000000000";
signal q1_bist:std_logic:='0';
signal q_reg:std_logic_vector(n-1 downto 0):="0000000000000000";
signal a_reg: std_logic_vector(n-1 downto 0):="0000000000000000";
signal ovf:std_logic:='0';
signal y_sum:std_logic_vector(n-1 downto 0):="0000000000000000";
signal subb_8:std_logic_vector(n-1 downto 0):="0000000000000000";
begin

q <= q_reg;
a <= a_reg;




subb_8 <= (others => subb);
y_sum <= b xor subb_8;



e1: entity WORK.uc 
 generic map(n)
port map(
  clk => clk,
  rst => rst,
  start => start,
  q0 =>q_reg(0),
  q_minus_1 => q1_bist,
  rsta =>rsta,
  loada =>loada,
  subb => subb,
  loadb => loadb,
  shraq => shraq,
  loadq => loadq,
  rstqm => rstqm,
  
  term => term
 ); 
 
 e2: entity WORK.fdn
  generic map(16)
  port map(
      
       d =>x,
       ce => loadb,
       clk => clk,
       rst => rst,
       q => b
 );
 
 e3: entity WORK.srrn
 generic map(n)
 port map(
         clk => clk,
         d => suma, 
         sri => a_reg(n-1),
         load => loada,
         rst =>rsta,
         ce => shraq,
         q => a_reg
 );
 
 
 e4: entity WORK.srrn
  generic map(n)
 port map(
         clk => clk,
         d => y, 
         sri => a_reg(0),
         load => loadq,
         rst =>rst,
         ce => shraq,
         q => q_reg
 );
 e5: entity WORK.fd
port map(
 clk =>clk,
 d => q_reg(0),
 ce => shraq,
 rst =>rstqm,
 q => q1_bist
);

e6: entity WORK.addn
 generic map(n)
port map(
x => y_sum,
y => a_reg,
tin => subb,
s => suma,
tout =>tout,
ovf =>ovf
);
end Behavioral;
