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
        ent : in std_logic_vector(n downto 0)--entrada que viene desde la alu
    );
end entity;

architecture arch of deco is
begin
    process (ent)        
    begin
    case ent is --sentencia para seleccionar la representacion en 7 segmentos de la salida de la alu
        when "0000" => sal <= "1111110";--0
        when "0001" => sal <= "1111101";--1
        when "0010" => sal <= "1111011";--2
        when "0011" => sal <= "1110111"; -- 3
        when "0100" => sal <= "1101111"; -- 4
        when "0101" => sal <= "1011111"; -- 5
        when "0110" => sal <= "0111111"; -- 6
        when "0111" => sal <= "0000000"; -- 7
        when "1000" => sal <= "0000000"; -- 8
        when "1001" => sal <= "0000000"; -- 9
        when others => sal <= "UUUUUUU";
    end case;
    end process;

end architecture;