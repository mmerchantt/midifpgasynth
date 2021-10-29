-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "09/26/2021 16:48:15"
                                                            
-- Vhdl Test Bench template for design  :  Example1
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY Example1_vhd_tst IS
END Example1_vhd_tst;
ARCHITECTURE Example1_arch OF Example1_vhd_tst IS
-- constants        
CONSTANT clk_period : TIME := 20 ns;
CONSTANT num_clk_cycles : INTEGER := 242900;  -- as long as the simulation needs to be                                       
-- signals                                                   
SIGNAL CLOCK_50 : STD_LOGIC := '0';
SIGNAL note1 : std_logic_vector(7 downto 0);
SIGNAL note2 : std_logic_vector(7 downto 0);
SIGNAL note3 : std_logic_vector(7 downto 0);
SIGNAL midiin : std_logic; --bit 7 6 5 4 row 1 2 3 4 // bit 3 2 1 0 column 1 2 3 4
SIGNAL leds : std_logic_vector(7 downto 0);

COMPONENT Example1
	PORT (
	CLOCK_50 : IN STD_LOGIC;
	midiin : IN std_logic;
	note1 : out std_logic_vector(7 downto 0);
	note2 : out std_logic_vector(7 downto 0);
	note3 : out std_logic_vector(7 downto 0);
	leds : OUT std_logic_vector(7 downto 0)
	);
END COMPONENT;
BEGIN
	i1 : Example1
	PORT MAP (
-- list connections between master ports and signals
	CLOCK_50 => CLOCK_50,
	note1 => note1,
	note2 => note2,
	note3 => note3,
	midiin => midiin,
	leds => leds
	);
	-- clock generation
ClockGen : PROCESS 
BEGIN
	for i in 1 to num_clk_cycles loop
		CLOCK_50 <= not clock_50;
		wait for clk_period /2;
		clock_50 <= not CLOCK_50;
		wait for clk_period /2;
	end loop;
	WAIT;
END PROCESS ClockGen;
                    
TestVectors : PROCESS
BEGIN
--CLOCK AND DATA CANNOT CHANGE AT SAME TIME
	midiin <= '1',
		'0' after 32.02 us,
		'1' after 32.04 us,
		'0' after 32.06 us,
		'1' after 32.07 us,
		'0' after 32.08 us, --start bit
		'1' after 32.09 us,
		'0' after 32.1 us,
		'1' after 32.105 us,
		'0' after 32.11 us,
		
		'1' after 64 us,
		'0' after 96 us,
		'0' after 128 us,
		'1' after 160 us,
		
		'0' after 192 us,
		'0' after 224 us,
		'0' after 256 us,
		'0' after 288 us,
		
		'1' after 320 us,
		'0' after 353 us,
		
		'0' after 385 us,
		'0' after 417 us,
		'1' after 449 us,
		'1' after 481 us,
		'1' after 513 us,
		'1' after 545 us,
		'0' after 577 us,
		'0' after 609 us,
		
		'1' after 640 us,
		'0' after 674 us,
		
		'0' after 706 us,
		'1' after 738 us,
		'1' after 770 us,
		'1' after 802 us,
		'1' after 834 us,
		'1' after 866 us,
		'1' after 898 us,
		'0' after 930 us,
		
		'1' after 962 us,
		--middle C midi signal 1001 0000 10 00111100 10 01000000 1
		--[note on][channelselect ignore][stopstartbits][middle C is 60][stopstartbits][halfvelocity][stopbit]
		'0' after 1032 us, --start bit
		
		'1' after 1064 us,
		'0' after 1096 us,
		'0' after 1128 us,
		'1' after 1160 us,
		
		'0' after 1192 us,
		'0' after 1224 us,
		'0' after 1256 us,
		'0' after 1288 us,
		
		'1' after 1320 us,
		'0' after 1353 us,
		
		'0' after 1385 us,
		'0' after 1417 us,
		'1' after 1449 us,
		'0' after 1481 us,
		'0' after 1513 us,
		'1' after 1545 us,
		'0' after 1577 us,
		'0' after 1609 us,
		
		'1' after 1640 us,
		'0' after 1674 us,
		
		'0' after 1706 us,
		'0' after 1738 us,
		'1' after 1770 us,
		'1' after 1802 us,
		'1' after 1834 us,
		'1' after 1866 us,
		'0' after 1898 us,
		'0' after 1930 us,
		
		'1' after 1962 us,
		----------
		'0' after 2032 us, --start bit
		
		'1' after 2064 us,
		'0' after 2096 us,
		'0' after 2128 us,
		'0' after 2160 us,
		
		'0' after 2192 us,
		'0' after 2224 us,
		'0' after 2256 us,
		'0' after 2288 us,
		
		'1' after 2320 us,
		'0' after 2353 us,
		
		'0' after 2385 us,
		'0' after 2417 us,
		'1' after 2449 us,
		'0' after 2481 us,
		'0' after 2513 us,
		'1' after 2545 us,
		'0' after 2577 us,
		'0' after 2609 us,
		
		'1' after 2640 us,
		'0' after 2674 us,
		
		'0' after 2706 us,
		'0' after 2738 us,
		'1' after 2770 us,
		'1' after 2802 us,
		'1' after 2834 us,
		'1' after 2866 us,
		'0' after 2898 us,
		'0' after 2930 us,
		
		'1' after 2962 us,
		--------------------------
		'0' after 3032 us, --start bit
		
		'1' after 3064 us,
		'0' after 3096 us,
		'0' after 3128 us,
		'0' after 3160 us,
		
		'0' after 3192 us,
		'0' after 3224 us,
		'0' after 3256 us,
		'0' after 3288 us,
		
		'1' after 3320 us,
		'0' after 3353 us,
		
		'0' after 3385 us,
		'0' after 3417 us,
		'1' after 3449 us,
		'1' after 3481 us,
		'1' after 3513 us,
		'1' after 3545 us,
		'0' after 3577 us,
		'0' after 3609 us,
		
		'1' after 3640 us,
		'0' after 3674 us,
		
		'0' after 3706 us,
		'1' after 3738 us,
		'1' after 3770 us,
		'1' after 3802 us,
		'1' after 3834 us,
		'1' after 3866 us,
		'1' after 3898 us,
		'0' after 3930 us,
		
		'1' after 3962 us;
		WAIT;
END PROCESS TestVectors;

END Example1_arch;
