----------------------------------------------------------------------------------
---- Company: Department of Electrical and Computer Engineering, University of Alberta
---- Engineer: Ryan Moro
-- 
-- Create Date: 08/31/2020 04:05:35 PM
-- Design Name: 
-- Module Name: seq_fsm_tb - Behavioral
-- Project Name: Lab 2
-- Target Devices: 
-- Tool Versions: 
-- Description: simulation test bench for sequence detector
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

entity seq_fsm_tb is

end seq_fsm_tb;

architecture Behavioral of seq_fsm_tb is

component seq_fsm is 
Port (clk           : in std_logic;
      reset         : in std_logic;
      seq_in        : in std_logic;
      output_detect : out std_logic);
end component;

signal clk_design : std_logic;
signal rst        : std_logic;
signal sequence_in      : std_logic;
signal fsm_detector_out : std_logic;
constant clk_period : time := 40 ns;

begin
    --port map the entity
    seq_map : seq_fsm port map(clk => clk_design,
                                reset => rst,
                                seq_in => sequence_in,
                                output_detect => fsm_detector_out);
                        
   clk_process :process
   begin
        clk_design <= '0';
        wait for clk_period/2;  
        clk_design <= '1';
        wait for clk_period/2;  
   end process;                                   

    stim_proc: PROCESS 
    begin
    rst <= '1';
    wait for 100ns;
    rst <= '0';
    
    --provide the test sequence to the design under test
    --test sequence for FSM - 101101101011
     sequence_in <= '1';
     wait for clk_period*2;
     sequence_in <= '0';
     wait for clk_period*2;
     sequence_in <= '1';
     wait for clk_period*2;
     sequence_in <= '1';
     wait for clk_period*2;
     sequence_in <= '0';
     wait for clk_period*2;
     sequence_in <= '1';
     wait for clk_period*2;
     sequence_in <= '1';
     wait for clk_period*2;
     sequence_in <= '0';
     wait for clk_period*2;
     sequence_in <= '1';
     wait for clk_period*2;
     sequence_in <= '0';
     wait for clk_period*2;
     sequence_in <= '1';
     wait for clk_period*2;
     sequence_in <= '1';
     wait for clk_period*2;
        
    end process;
end Behavioral;
