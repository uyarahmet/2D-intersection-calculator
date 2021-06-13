library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity coordinate_calculator_tb is
--  Port ( );
end coordinate_calculator_tb;

architecture Behavioral of coordinate_calculator_tb is

  component coordinate_calculator is
  Port(   
          clk_i          : in   std_logic;
          rst_i          : in   std_logic;
          m_i            : in   std_logic_vector (7  downto 0) ;
          n_i            : in   std_logic_vector (7  downto 0) ;
          a_i            : in   std_logic_vector (7  downto 0) ;
          b_i            : in   std_logic_vector (7  downto 0) ;
          x_o            : out  std_logic_vector (15 downto 0) ;
          y_o            : out  std_logic_vector (15 downto 0) ;
          coordinate_rdy : out  std_logic                     );
  end component;

  signal clk_i           : std_logic;
  signal rst_i           : std_logic;
  signal m_i             : std_logic_vector(7  downto 0);
  signal n_i             : std_logic_vector(7  downto 0);
  signal a_i             : std_logic_vector(7  downto 0);
  signal b_i             : std_logic_vector(7  downto 0);
  signal x_o             : std_logic_vector(15 downto 0);
  signal y_o             : std_logic_vector(15 downto 0);
  signal coordinate_rdy  : std_logic;
  
  signal expected_x      : std_logic_vector(15 downto 0);
  signal expected_y      : std_logic_vector(15 downto 0);

begin

  res_gen: process
  begin
    rst_i <= '1';
    wait for 10 ns;
    rst_i <= '0';
    wait;
  end process res_gen;

  clk_gen: process
  begin
    clk_i <= '0';
    wait for 50 ns;
    clk_i <= '1';
    wait for 50 ns;
  end process;

  coordinate_calculator_inst: coordinate_calculator
  Port map(   
          clk_i           => clk_i          ,
          rst_i           => rst_i          ,
          m_i             => m_i            ,
          n_i             => n_i            ,
          a_i             => a_i            ,
          b_i             => b_i            ,
          x_o             => x_o            ,
          y_o             => y_o            ,
          coordinate_rdy  => coordinate_rdy);
  
  stim_gen: process
  begin
    -- y = 3x + 12 || y = 4x + 9  --> y = (x15)21 , x = 3
    m_i        <= x"03"; -- 03 
    n_i        <= x"0c"; -- 12
    a_i        <= x"04"; -- 04
    b_i        <= x"09"; -- 09
    expected_x <= x"0003"; -- x03 = 03;
    expected_y <= x"0015"; -- x15 = 15;
    wait for 50 ns;
    -- gradient same
    m_i        <= x"03"; -- 03
    n_i        <= x"0c"; -- 12
    a_i        <= x"03"; -- 03
    b_i        <= x"09"; -- 09   
    expected_x <= (others => 'Z'); -- xZZ;
    expected_y <= (others => 'Z'); -- xZZ;
    wait for 50 ns;
    -- y = 5x + 60 || y = 6x + 40  --> y = (xa0)160 , x = (x14)20  
    m_i        <= x"05"; -- 05
    n_i        <= x"3c"; -- 60
    a_i        <= x"06"; -- 06
    b_i        <= x"28"; -- 40  
    expected_x <= x"0014"; -- x14 = 20;
    expected_y <= x"00a0"; -- xa0 = 160;
    wait for 50 ns;
    -- y = x + 250 || y = 4x + 100  --> y = (x12c)300 , x = (x32)50  	
    m_i        <= x"01"; -- 01
    n_i        <= x"fa"; -- 250 
    a_i        <= x"04"; -- 04
    b_i        <= x"64"; -- 100    
    expected_x <= x"0032"; -- x032 = 50;
    expected_y <= x"012c"; -- x12c = 300;
    wait for 50 ns;
    wait;
  end process;

end Behavioral;
