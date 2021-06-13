library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity binary_addsub is
	port
	(
		-- Input ports
		a, b	   : in std_logic_vector(7 downto 0);
		sub      : in std_logic; -- 1 to subtract

		-- Output ports
		sum	: out std_logic_vector(8 downto 0)
	);
end binary_addsub;


architecture a of binary_addsub is


begin
	
	process(a, b, sub)
	begin
		if sub = '1' then 
			sum <= ('0' & a) + not ('0' & b) + "000000001";
		else 
			sum <= ('0' & a) + ('0' & b);
		end if;
	end process;
end a;
