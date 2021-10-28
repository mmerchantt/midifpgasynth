library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use std.textio.all;
use IEEE.std_logic_textio.all;

entity Example1 is

	port(
		  CLOCK_50 : in std_logic; --Clock Input
		  midiin : in std_logic; --bit 7 6 5 4 row 1 2 3 4 // bit 3 2 1 0 column 1 2 3 4
		  leds : out std_logic_vector(7 downto 0)--FPGA midi input // USES GPIO_010
			--p_i2s_bit_clock : out std_logic; -- clock out to i2s
	  	   --p_i2s_data_line : out std_logic; -- data out to i2s
			--p_i2s_word_select : out std_logic -- channel out to i2s
		 );  
		  
	  
end Example1;

architecture behaviour of Example1 is
	
--////////////////SIGNAL INITS///////////////////////////
signal midiin : std_logic_vector(28 downto 0); -- ignore 30th bit because it's a stopbit always on
-- missing bits are stop and start bits
-- bits 28-24 are status (including 28 and 24 etc)
-- bits 23-20 are channel
-- bits 17-10 are data 1
-- bits 7-0 are data 2

signal bytesreceivedno : std_logic_vector(7 downto 0) := X"00"; --bytes received, 
--tells us which databyte we are reading by counting up, eg data1  or data2

signal data_available : std_logic; --boolean to see if midi_rx is giving us info

signal midicount : std_logic_vector(11 downto 0) := X"000";
signal miditicks : std_logic_vector(11 downto 0) := X"640"; --1600 = 50MHz / 31250 to split clock up into midi clock
--///////////////////////////////////////////////////////


begin

	keyproc : process(CLOCK_50)
		begin
		if rising_edge(CLOCK_50) then --+veedge clock.
		
			leds <= midiin(28 downto 0) & data_available; -- so we can test to see midi signal and if data
																		 -- availabe is working properly
			 
			if ((midiin = '0') and (data_available = '0')) then -- midi_rx = 0 at start bit
			midicount <= X"000";	
			bytesreceivedno <= X"00";
			midiin <= (others => '0');
			data_available <= '1';
			end if;
			
			if (data_available = '1') then

				midicount <= midicount + 1;
						
						if ((midicount = miditicks) and (bytesreceivedno <= X"1D")) then

							midiin(28 downto 0) <= midiin(27 downto 0) & midiin;
							bytesreceivedno <= bytesreceivedno + 1;	
							midicount <= X"000";
						
						end if;
						
						if (bytesreceivedno = X"1D") then
							
							data_available <= '0';	
						
						end if;			
						
			end if;
					
		end if;
		
end process keyproc;
--end process midibytereader;
	
end behaviour; 