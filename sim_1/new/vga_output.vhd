----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2020 16:00:25
-- Design Name: 
-- Module Name: vga_output - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;

-- Agregar librerias necesarias
use ieee.std_logic_textio.all;
library STD;
use STD.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_output is
end vga_output;

architecture Behavioral of vga_output is

    component vga_conection
        Port (
            clk: in std_logic;
            rst: in std_logic;
            fsmin: in std_logic := '1';
            deco7: out std_logic_vector (6 downto 0);
            rgb_out: out std_logic_vector (11 downto 0);
            hsync, vsync: out std_logic);
        end component;
        
    Signal clk: std_logic :='0'; 
    Signal rst: std_logic := '0'; 
    signal hsync: std_logic;
    signal vsync: std_logic;
    signal fsmin: std_logic := '1';
    Signal deco7 : std_logic_vector (6 downto 0) := "0000000";
    signal rgb_out : std_logic_vector (11 downto 0);       
    constant TbPeriod : time := 20 ns; 
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';
    
begin

    vg: vga_conection port map 
    (
        clk => clk, 
        rst => rst,
        hsync => hsync,
        vsync => vsync,
        fsmin => fsmin,
        deco7 => deco7,
        rgb_out => rgb_out
    );
    
    clk <= not clk after 10 ns;      --reloj de 50MHz
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';     --reloj de 50MHz para los pixeles
    clk <= TbClock;
    rit:process
    begin
         rst <='1';
         wait for 20 ns;
         rst <= '0';
         wait;     
    end process;
    
    stimuli : process
	  begin
        fsmin <= '1';
        wait for 16 ms;
        fsmin <= '1';
        wait for 16 ms;
        fsmin <= '1';
        wait for 16 ms;
        fsmin <= '0';
        wait until vsync'event and vsync='0';
--        wait for 16 ms;
        fsmin <= '1';
        wait for 16 ms;
        fsmin <= '1';
        wait for 16 ms;
        fsmin <= '0';
        wait;
        end process;
        
        process(clk)
          
    	file file_pointer: text open WRITE_MODE is "vga_sync_test.txt";
	       variable line_el: line;
                -- EDIT Adapt initialization as needed 
           -- EDIT Adapt initialization as needed		
           begin
           if rising_edge(clk) then

			-- Write the time
			write(line_el, now); -- write the line.
			write(line_el, string'(":")); -- write the line.

			-- Write the hsync
			write(line_el, string'(" "));
			write(line_el, hsync); -- write the line.

			-- Write the vsync
			write(line_el, string'(" "));
			write(line_el, vsync); -- write the line.

			-- Write the red
			write(line_el, string'(" "));
			write(line_el, rgb_out(11 downto 8)); -- write the line (Red color).
			--write(line_el, red); -- write the line (Red color).

			-- Write the green
			write(line_el, string'(" "));
			write(line_el, rgb_out(7 downto 4)); -- write the line (Green color).
			--write(line_el, green); -- write the line (Green color).


        	-- Write the blue
        	write(line_el, string'(" "));
			write(line_el, rgb_out(3 downto 0)); -- write the line (Blue color).
			--write(line_el, blue); -- write the line (Blue color).

    	    writeline(file_pointer, line_el); -- write the contents into the file.

    	end if;
        
    end process;
end Behavioral;