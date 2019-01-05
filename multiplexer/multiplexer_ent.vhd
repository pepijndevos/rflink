library ieee;
use ieee.std_logic_1164.all;

entity multiplexer is
    generic (
       button_value : std_logic:='1'

      );
  port (
		reset				: in std_logic;
		clk					: in std_logic;
		switches			: in std_logic_vector(9 downto 0);  -- switches
		buttons			: in std_logic_vector(3 downto 0);
		buttons_0000000000	: out std_logic_vector(3 downto 0);  -- buttons
		leds_0000000000		: in std_logic_vector(9 downto 0) := (others => '0');  -- leds
		buttons_1000000000	: out std_logic_vector(3 downto 0);  -- buttons
		leds_1000000000		: in std_logic_vector(9 downto 0) := (others => '0');  -- leds
		buttons_0100000000	: out std_logic_vector(3 downto 0);  -- buttons
		leds_0100000000		: in std_logic_vector(9 downto 0) := (others => '0');  -- leds
		buttons_0010000000	: out std_logic_vector(3 downto 0);  -- buttons
		leds_0010000000		: in std_logic_vector(9 downto 0) := (others => '0');  -- leds
		buttons_0001000000	: out std_logic_vector(3 downto 0);  -- buttons
		leds_0001000000		: in std_logic_vector(9 downto 0) := (others => '0');  -- leds
		buttons_0000100000	: out std_logic_vector(3 downto 0);  -- buttons
		leds_0000100000		: in std_logic_vector(9 downto 0) := (others => '0');  -- leds
		buttons_0000010000	: out std_logic_vector(3 downto 0);  -- buttons
		leds_0000010000		: in std_logic_vector(9 downto 0) := (others => '0');  -- leds
		buttons_0000001000	: out std_logic_vector(3 downto 0);  -- buttons
		leds_0000001000		: in std_logic_vector(9 downto 0) := (others => '0');  -- leds
		buttons_0000000100	: out std_logic_vector(3 downto 0);  -- buttons
		leds_0000000100		: in std_logic_vector(9 downto 0) := (others => '0');  -- leds
		buttons_0000000010	: out std_logic_vector(3 downto 0);  -- buttons
		leds_0000000010		: in std_logic_vector(9 downto 0) := (others => '0');  -- leds		
		buttons_0000000001	: out std_logic_vector(3 downto 0);  -- buttons
		leds_0000000001		: in std_logic_vector(9 downto 0) := (others => '0');  -- leds
		leds						: out std_logic_vector(9 downto 0)
	);
end multiplexer;
