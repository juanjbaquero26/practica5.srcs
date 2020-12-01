library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
entity divisor is
port (
	clk50mhz: 	in STD_LOGIC;   
	clkdiv:		out STD_LOGIC
);
end divisor;

architecture behavioral of divisor is
	constant max_count: INTEGER := 800000;  --Numero de ciclos para cambiar el reloj
	signal count: INTEGER range 0 to max_count+1;   --contador que cambia los estados del reloj
	signal clk_state: STD_LOGIC := '0';       -- senal que se lleva a la salida 
	
begin
    process(clk50mhz)
	begin
		if (clk50mhz'event and clk50mhz='1') then    -- comprobamos si hay cambios en el reloj
			if (count = max_count) then          
				count <= 0;                  -- cuando el contador llegue a los ciclos establecidos lo reiniciamos 
				clk_state <= not clk_state;  -- cambiamos la senal 
			else
				count <= count + 1;
			end if;
		end if;
	end process;
	
	process (clk_state)
	begin
		clkdiv <= clk_state;      --enviamos la senal al puerto de salida
	end process;
	
end behavioral;