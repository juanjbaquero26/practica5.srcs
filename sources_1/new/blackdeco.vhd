----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.12.2020 23:13:11
-- Design Name: 
-- Module Name: blackdeco - Behavioral
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

entity blackdeco  is --modulo para verificar el funcionamiento de la fms, el deco y el divisor de freceuncia
  Port (
      clk: in std_logic;
      rst: in std_logic;
      fsmin: in std_logic;
      deco7: out std_logic_vector (6 downto 0);
      fsm1: out std_logic_vector (1 downto 0)
  );
end blackdeco;

architecture Behavioral of blackdeco is

    component divisor --instanciacion divisor
        port (
            clk50mhz: 	in STD_LOGIC;   
            clkdiv:		out STD_LOGIC
        );
        end component;        
    component fsm --instanciacion fms
        Port (
            x : in std_logic;
            clk: in std_logic;
            reset : in std_logic;
            z: out std_logic_vector (1 downto 0);
            fsm_state: out std_logic_vector(2 downto 0)
        );
        end component;      
    component deco --instanciacion deco
        port (
            sal : out  std_logic_vector(6 downto 0); 
            ent : in std_logic_vector(2 downto 0)
        );        
    end component;
    signal clk100ns: std_logic := '0'; --señal que hace de cable entre el divisor y la fms
    signal fsm_states: std_logic_vector (2 downto 0) := "000";--cable que hace de conexion entre la fms y el deco
    
begin
    div: divisor port map(
        clk50mhz => clk,
        clkdiv => clk100ns
    );
    fms: fsm port map(
        x => fsmin,
        clk => clk100ns,
        reset => rst,
        z => fsm1,
        fsm_state => fsm_states
    );
    dec: deco port map (
        ent => fsm_states,
        sal => deco7
    );

end Behavioral;
