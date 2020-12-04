----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.11.2020 14:55:07
-- Design Name: 
-- Module Name: deco_7seg - Behavioral
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
use IEEE.Std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
library UNISIM;
use UNISIM.VComponents.all;

entity deco is
    generic(n: integer := 3);
    port (
        sal : out  std_logic_vector(2**N-2 downto 0); --salida de el deco de 7 segmentos
        ent : in std_logic_vector(n-1 downto 0)--entrada que viene desde la alu
    );
end entity;

architecture arch of deco is
begin
    process (ent)        
    begin
    case ent is --sentencia para seleccionar la representacion en 7 segmentos de la salida de la alu
        when "000" => sal <= "1111110";--0
        when "001" => sal <= "1111101";--1
        when "010" => sal <= "1111011";--2
        when "011" => sal <= "1110111"; -- 3
        when "100" => sal <= "1101111"; -- 4
        when "101" => sal <= "1011111"; -- 5
        when "110" => sal <= "0111111"; -- 6
        when "111" => sal <= "0000000"; -- 7
        when others => sal <= "UUUUUUU";
    end case;
    end process;

end architecture;