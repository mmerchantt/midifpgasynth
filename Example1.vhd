library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_textio.all;
use ieee.numeric_std.all;  

entity Example1 is

	port(
		  CLOCK_50 : in std_logic; --Clock Input
		  midiin : in std_logic; --bit 7 6 5 4 row 1 2 3 4 // bit 3 2 1 0 column 1 2 3 4
		  note1 : out std_logic_vector(7 downto 0);
		  note2 : out std_logic_vector(7 downto 0);
		  note3 : out std_logic_vector(7 downto 0);
		  leds : out std_logic_vector(7 downto 0)--FPGA midi input // USES GPIO_010
		 );  
		  
	  
end Example1;

architecture behaviour of Example1 is
	
--////////////////SIGNAL INITS///////////////////////////
signal datain : std_logic_vector(7 downto 0) := (others => '0');
-- missing bits are stop and start bits
signal byte1 : std_logic_vector(7 downto 0) := (others => '0');
signal byte2 : std_logic_vector(7 downto 0) := (others => '0');
signal byte3 : std_logic_vector(7 downto 0) := (others => '0');
---------------------------------------------------------
signal note1on : std_logic_vector(7 downto 0) := (others => '0');
signal note2on : std_logic_vector(7 downto 0) := (others => '0');
signal note3on : std_logic_vector(7 downto 0) := (others => '0');
---------------------------------------------------------
signal bitsreceivedno : std_logic_vector(3 downto 0) := (others => '0');
--tells us which databyte we are reading by counting up, eg data1  or data2

 --boolean to see if midi_rx is giving us info
signal wdata : std_logic_vector(2 downto 0) := (others => '0');
signal condition : std_logic_vector(1 downto 0) := (others => '0');


signal midicount : std_logic_vector(11 downto 0) := (others => '0');
signal miditicks : std_logic_vector(11 downto 0) := X"640"; --1600 = 50MHz / 31250 to split clock up into midi clock
--///////////////////////////////////////////////////////
signal dticks : std_logic_vector(7 downto 0) := "00001010";
signal dcount : std_logic_vector(7 downto 0) := (others => '0');
--signal startdata : std_logic := '0';

begin

	keyproc : process(CLOCK_50)
		begin
		if rising_edge(CLOCK_50) then --+veedge clock.
		if midiin = '0' then
			leds<=(others => '1');
		end if;
		case (condition) is
			
				when "00" => --waiting for start bit
					if midiin = '0' then
						if dcount >= dticks then
							midicount <= (others => '0');
							datain <= (others => '0');
							bitsreceivedno <= (others => '0');
							condition <= "01";

						else
							dcount <= dcount + '1';
						end if;
					else
						dcount <= (others => '0');
					end if;
				
				
				when "01" => --skip 1 bit (start bit) and count 8 bits
					midicount <= midicount + '1';		
						if midicount = miditicks then
							datain(7 downto 0) <= datain(6 downto 0) & midiin;
							bitsreceivedno <= bitsreceivedno + '1';
							midicount <= (others => '0');
						
						end if;	
						if bitsreceivedno = X"8" then
							condition <= "10";
							midicount <= (others => '0');
						end if;	
				
				
				when "10" => --reached stop bit
						midicount <= midicount + '1';
						if midicount = miditicks then
							if (wdata < "011") then
							wdata <= wdata + '1';
							end if;
							dcount <= (others => '0');
							bitsreceivedno <= (others => '0');
							condition <= "11";
						end if;
						
					
					
				when "11" => 
									
					case (wdata) is --wdata tells which byte to savedata in, once all data receive then outputs
									
						when "001" =>
								byte1 <= datain;
								condition <= "00";
						
						when "010" =>
								byte2 <= datain;
								condition <= "00";
						
						when "011" =>
								byte3 <= datain;
								wdata <= wdata +'1';
						
						when "100" =>
								if byte1 = X"90" then
															--	leds <= byte2;

									if note1on = X"00" then
										note1on <= byte2;
										note1 <= byte2;
									elsif note2on = X"00" then
										note2on <= byte2;
										note2 <= byte2;
									elsif note3on = X"00" then
										note3on <= byte2;
										note3 <= byte2;
									end if;
								end if;
								if byte1 = X"80" then
									if note1on = byte2 then
										note1on <= X"00";
										note1 <= X"00";
									elsif note2on = byte2 then
										note2on <= X"00";
										note2 <= X"00";
									elsif note3on = byte2 then
										note3on <= X"00";
										note3 <= X"00";
									end if;
									
								end if;
								
								condition <= "00";
								wdata <= "000";
								
								
						when others =>
									
					
					end case;
						
				when others =>
						
			
			end case;
				
			
		end if;			
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			

		
end process keyproc;
--end process midibytereader;
	
end behaviour; 