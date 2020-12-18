----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.12.2020 22:28:32
-- Design Name: 
-- Module Name: leds - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library STD;
use STD.textio.all;

use STD.textio.all;
use IEEE.std_logic_textio.all;

library UNISIM;
use UNISIM.VComponents.all;


entity leds is
end leds;

architecture Behavioral of leds is--instanciacion del modulo black deco en el cual se verifica la fms, el deco y el diviosor
    component blackdeco
    port(
        clk: in std_logic;
        rst: in std_logic;
        fsmin: in std_logic :='0';
        deco7: out std_logic_vector (6 downto 0);
        fsm1: out std_logic_vector (1 downto 0)
    );
    end component;
    
        signal clk: std_logic;--señales necesarias para verifricar el funcionamiento de nuestro modulo
        signal rst: std_logic;
        signal fsmin: std_logic;
        signal deco7: std_logic_vector (6 downto 0);
        signal fsm1: std_logic_vector (1 downto 0);
        
        constant TbPeriod : time := 20 ns; -- señal de reloj necesaria para el divisor
        signal TbClock : std_logic := '0';
        signal TbSimEnded : std_logic := '0';
       
        
begin

   uut: blackdeco
    port map (
        clk => clk,
        rst => rst,
        fsmin => fsmin,
        deco7 => deco7,
        fsm1 => fsm1
  );
    
     -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';
    clk <= TbClock;
   rit:process--proceso para empezar el circuito en reset
    begin
         rst <='1';
         wait for 20 ns;
         rst <= '0';
         wait;
         
    end process;
   stm: process --proceso para verificar el correcto funcionamiento de nuestra fms
   begin
     
       fsmin <= '0';
       wait for 20 ns;
       fsmin <= '1';
       wait for 20 ns;
       fsmin <= '1';
       wait for 20 ns;
       fsmin <='1';
       wait for 20 ns;
       fsmin <='1';
       wait for 20 ns;
       fsmin <='1';
       wait for 20 ns;
       fsmin <='1';
       wait for 20 ns;
       fsmin <='1';
       wait for 20 ns;
       fsmin <='1';
       wait for 20 ns;
       fsmin <='0';
       wait for 20 ns;
   
          
    end process;
    
        
        
end Behavioral;
