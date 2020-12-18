----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2020 15:54:51
-- Design Name: 
-- Module Name: fsm - Behavioral
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

entity fsm is --instanciacion de entradas y salidas necesarias para la fms
 Port (
  x : in std_logic;--entrada
  clk: in std_logic;
  reset : in std_logic;
  z: out std_logic_vector (1 downto 0);--salidas z1 y z2 en bus
  fsm_state: out std_logic_vector(2 downto 0)--valor del estado  
  );
end fsm;

architecture Behavioral of fsm is

type  state_type is(S0,S1,S2,S3,S4);--se crean los estados necesarios.
SIGNAL CURRENT_STATE, NEXT_STATE:STATE_TYPE;--señales modo estado, para el estado actual y el estado siguiente

begin
SYNC_CURRENT_STATE:PROCESS(CLK,RESET)--proceso para sincronizar el estado actual con el reset
    BEGIN
        IF(RESET='1')THEN
            CURRENT_STATE <= S0;
        END IF;
        IF(RISING_EDGE(CLK))THEN--cuando hay un flanco de reloj el estado actual sera el siguiente
            CURRENT_STATE <=NEXT_STATE;
        END IF;
    END PROCESS;
    
NEXT_STATE_LOGIC: PROCESS(X,CURRENT_STATE)--proceso para cambiar de estado y mirar el estado en el que estoy
BEGIN
    NEXT_STATE <= S0;--empezamos en el primer estado
    CASE(CURRENT_STATE)is
        when S0 =>
            IF(X='1')THEN
                NEXT_STATE <= S1;--si recibo un 1 en el esatdo 0, me voy para el estado 1 y su salida es fmsstate
                fsm_state <= "001";
            ELSE
                NEXT_STATE <=S0;--si recibo un 0 en el esatdo 0, me voy para el estado 0 y su salida es fmsstate
                fsm_state <= "000";
            END IF;
        WHEN S1 =>
            IF(X='1')THEN
                NEXT_STATE <=S2;--si recibo un 1 en el esatdo 1, me voy para el estado 2 y su salida es fmsstate
                fsm_state <= "011";
            ELSE
                NEXT_STATE <=S0;--si recibo un 0 en el esatdo 1, me voy para el estado 0 y su salida es fmsstate
                fsm_state <= "010";
                
            END IF;    
        WHEN S2 =>
            IF(X='1')THEN
                NEXT_STATE <=S3;--si recibo un 1 en el esatdo 2, me voy para el estado 3 y su salida es fmsstate
                fsm_state <= "111";
            ELSE
                NEXT_STATE <=S4;--si recibo un 0 en el esatdo 2, me voy para el estado 4 y su salida es fmsstate
                fsm_state <= "110";
            END IF;    
        WHEN S3 =>
            IF(X='1')THEN
                NEXT_STATE <=S3;--si recibo un 1 en el esatdo 3, me voy para el estado 3 y su salida es fmsstate
                fsm_state <= "111";
            ELSE
                NEXT_STATE <=S4;--si recibo un 0 en el esatdo 3, me voy para el estado 4y su salida es fmsstate
                fsm_state <= "110";
            END IF;
        WHEN S4 =>
            IF(X='1')THEN--si recibo un 1 en el esatdo 4, me voy para el estado 1 y su salida es fmsstate
                NEXT_STATE <=S1;
                fsm_state <= "101";
            ELSE
                NEXT_STATE <=S0;--si recibo un 0 en el esatdo 4, me voy para el estado 0 y su salida es fmsstate
                fsm_state <= "100";
            END IF;            
         WHEN OTHERS => 
         NEXT_STATE <= S0;--si recibo un 1 en el esatdo o, me voy para el estado 1
         fsm_state <= "100";
     END CASE;
END PROCESS;
OUTPUT_LOGIC: PROCESS(CURRENT_STATE)--proceso para encontrar las salidas z1 y z2 dependiendo del estado
BEGIN
    CASE(CURRENT_STATE)IS
        WHEN S0 =>
            Z<="11";--no se ha cumplido ninguna condicion para que z1 o z2 cambie
        WHEN S1 =>
            Z<="11";--no se ha cumplido ninguna condicion para que z1 o z2 cambie
        WHEN S2 =>
            Z<="11";--no se ha cumplido ninguna condicion para que z1 o z2 cambie
        WHEN S3 =>
            Z<="01";-- en este estado se cumple la condicion de z1 y este cambia   
        WHEN S4 =>
            Z<="10";-- en este estado se cumple la condicion de z2 y este cambia                 
        WHEN OTHERS =>
            Z<="11";
      END CASE;
END PROCESS;      
    
end Behavioral;

