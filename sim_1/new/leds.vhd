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

use STD.textio.all;
use IEEE.std_logic_textio.all;

library UNISIM;
use UNISIM.VComponents.all;


entity leds is
end leds;

architecture Behavioral of leds is
    component blackdeco
    port(
        clk: in std_logic;
        rst: in std_logic;
        fsmin: in std_logic;
        deco7: out std_logic_vector (6 downto 0);
        fsm1: out std_logic_vector (1 downto 0);
        fsm2: out std_logic_vector (1 downto 0)
    );
    end component;
    
begin


end Behavioral;
