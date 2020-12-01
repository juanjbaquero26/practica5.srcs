----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2020 16:14:13
-- Design Name: 
-- Module Name: draw - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity draw is
    Port ( pix_x : in STD_LOGIC_VECTOR (9 downto 0);
           pix_y : in STD_LOGIC_VECTOR (9 downto 0);
           sw : in STD_LOGIC_VECTOR (1 downto 0);
           video_on: in std_logic;
           rgb_out : out STD_LOGIC_VECTOR (11 downto 0));
end draw;

architecture Behavioral of draw is

signal negro: STD_LOGIC_VECTOR (11 downto 0);
signal blanco: STD_LOGIC_VECTOR (11 downto 0);

begin

negro <= x"000";
blanco<=x"FFF";

process (sw,pix_x,pix_y)
	begin
	case sw is
		when "01" => --7
			      if (((pix_x >= 100) and (pix_x <= 400)) and ((pix_y >= 50) and (pix_y <= 100))) then rgb_out <= negro; 
			      elsif (((pix_x >= 300) and (pix_x <= 400)) and ((pix_y >= 101) and (pix_y <= 150))) then rgb_out <= negro;
		          elsif (((pix_x >= 200) and (pix_x <= 400)) and ((pix_y >= 151) and (pix_y <= 200))) then rgb_out <= negro;
		          elsif (((pix_x >= 300) and (pix_x <= 400)) and ((pix_y >= 201) and (pix_y <= 350))) then rgb_out <= negro;
			      else rgb_out <= blanco;
			      end if;
		when "10" => --f
			      if (((pix_x >= 100) and (pix_x <= 400)) and ((pix_y >= 50) and (pix_y <= 100))) then rgb_out <= negro; 
			      elsif (((pix_x >= 100) and (pix_x <= 200)) and ((pix_y >= 101) and (pix_y <= 150))) then rgb_out <= negro;
		          elsif (((pix_x >= 100) and (pix_x <= 300)) and ((pix_y >= 151) and (pix_y <= 200))) then rgb_out <= negro;
		          elsif (((pix_x >= 100) and (pix_x <= 200)) and ((pix_y >= 201) and (pix_y <= 350))) then rgb_out <= negro;
			      else rgb_out <= blanco;
			      end if;
		when "00" => --7
			      if (((pix_x >= 100) and (pix_x <= 400)) and ((pix_y >= 50) and (pix_y <= 100))) then rgb_out <= negro; 
			      elsif (((pix_x >= 300) and (pix_x <= 400)) and ((pix_y >= 101) and (pix_y <= 150))) then rgb_out <= negro;
		          elsif (((pix_x >= 200) and (pix_x <= 400)) and ((pix_y >= 151) and (pix_y <= 200))) then rgb_out <= negro;
		          elsif (((pix_x >= 300) and (pix_x <= 400)) and ((pix_y >= 201) and (pix_y <= 350))) then rgb_out <= negro;
			      else rgb_out <= blanco;
			      end if;
		end case;
end process;			      
end Behavioral;
