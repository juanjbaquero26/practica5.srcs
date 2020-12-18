----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2020 16:01:37
-- Design Name: 
-- Module Name: vga_conection - Behavioral
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

entity vga_conection is --entidad creada para el modulo final del proyecto
  Port (
      clk: in std_logic;
      rst: in std_logic;
      fsmin: in std_logic;
      deco7: out std_logic_vector (6 downto 0);
      rgb_out: out std_logic_vector (11 downto 0);
      hsync, vsync: out std_logic
  );
end vga_conection;

architecture Behavioral of vga_conection is

    component divisor--instanciacion de divisor
        port (
            clk50mhz: 	in STD_LOGIC;   
            clkdiv:		out STD_LOGIC
        );
        end component;        
    component fsm--instanciacion de maquina de estados
        Port (
            x : in std_logic;
            clk: in std_logic;
            reset : in std_logic;
            z: out std_logic_vector (1 downto 0);
            fsm_state: out std_logic_vector(2 downto 0)
        );
        end component; 
    component vga_ctrl_640x480 is --instanciacion de la vga
        port (
                clk, rst: in std_logic;
                hsync, vsync: out std_logic;
                pixel_x, pixel_y: out std_logic_vector (9 downto 0);
                video_on, p_tick: out std_logic
        );
        end component;   
    component draw is --instanciacion del modulo del dibujo
        Port ( pix_x : in STD_LOGIC_VECTOR (9 downto 0);
               pix_y : in STD_LOGIC_VECTOR (9 downto 0);
               sw : in STD_LOGIC_VECTOR (1 downto 0);
               video_on: in std_logic;
               rgb_out : out STD_LOGIC_VECTOR (11 downto 0));
        end component;  
    component deco --instanciacion de deco
        port (
            sal : out  std_logic_vector(6 downto 0); 
            ent : in std_logic_vector(2 downto 0)
        );        
    end component;
    
    signal sig_pixel_x, sig_pixel_y:  std_logic_vector (9 downto 0);--señales que son cables en nuestro modulo para diferentes conexiones en el
    signal sig_video_on: std_logic;
    signal clk100ns: std_logic := '0';
    signal fsm_states: std_logic_vector (2 downto 0) := "000";
    signal fsm1: std_logic_vector (1 downto 0) := "00";
    
begin
    div: divisor port map(
        clk50mhz => clk,
        clkdiv => clk100ns
    );
    vga : vga_ctrl_640x480 port map (
        clk=>clk, 
        rst=>rst,
        hsync=>hsync,
        vsync=>vsync,
        pixel_x=>sig_pixel_x,
        pixel_y=>sig_pixel_y,
        video_on=>sig_video_on,
        p_tick=>OPEN
     );
     fms: fsm port map(
        x => fsmin,
        clk => clk100ns,
        reset => rst,
        z => fsm1,
        fsm_state => fsm_states
    );
    draw1 : draw port map (
        pix_x =>sig_pixel_x,
        pix_y =>sig_pixel_y,
        sw =>fsm1,
        video_on=>sig_video_on,
        rgb_out =>rgb_out
    );
    dec: deco port map (
        ent => fsm_states,
        sal => deco7
    );
end Behavioral;
