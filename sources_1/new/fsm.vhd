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

entity fsm is
 Port (
  x : in std_logic;
  clk: in std_logic;
  reset : in std_logic;
  z: out std_logic_vector (1 downto 0);
  fsm_state: out std_logic_vector(2 downto 0)  --revisar porque falta (?)
  );
end fsm;

architecture Behavioral of fsm is

type  state_type is(S0,S1,S2,S3,S4);
SIGNAL CURRENT_STATE, NEXT_STATE:STATE_TYPE;

begin
SYNC_CURRENT_STATE:PROCESS(CLK,RESET)
    BEGIN
        IF(RESET='1')THEN
            CURRENT_STATE <= S0;
        END IF;
        IF(RISING_EDGE(CLK))THEN
            CURRENT_STATE <=NEXT_STATE;
        END IF;
    END PROCESS;
    
NEXT_STATE_LOGIC: PROCESS(X,CURRENT_STATE)
BEGIN
    NEXT_STATE <= S0;
    CASE(CURRENT_STATE)is
        when S0 =>
            IF(X='1')THEN
                NEXT_STATE <= S1;
                fsm_state <= "001";
            ELSE
                NEXT_STATE <=S0;
                fsm_state <= "000";
            END IF;
        WHEN S1 =>
            IF(X='1')THEN
                NEXT_STATE <=S2;
                fsm_state <= "011";
            ELSE
                NEXT_STATE <=S0;
                fsm_state <= "010";
                
            END IF;    
        WHEN S2 =>
            IF(X='1')THEN
                NEXT_STATE <=S3;
                fsm_state <= "111";
            ELSE
                NEXT_STATE <=S4;
                fsm_state <= "110";
            END IF;    
        WHEN S3 =>
            IF(X='1')THEN
                NEXT_STATE <=S3;
                fsm_state <= "111";
            ELSE
                NEXT_STATE <=S4;
                fsm_state <= "110";
            END IF;
        WHEN S4 =>
            IF(X='1')THEN
                NEXT_STATE <=S1;
                fsm_state <= "101";
            ELSE
                NEXT_STATE <=S0;
                fsm_state <= "100";
            END IF;            
         WHEN OTHERS => 
         NEXT_STATE <= S0;
         fsm_state <= "000";
     END CASE;
END PROCESS;
OUTPUT_LOGIC: PROCESS(CURRENT_STATE)
BEGIN
    CASE(CURRENT_STATE)IS
        WHEN S0 =>
            Z<="11";
        WHEN S1 =>
            Z<="11";
        WHEN S2 =>
            Z<="11";
        WHEN S3 =>
            Z<="01";  
        WHEN S4 =>
            Z<="10";                 
        WHEN OTHERS =>
            Z<="11";
      END CASE;
END PROCESS;      
    
end Behavioral;

