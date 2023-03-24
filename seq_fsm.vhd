------------------------------------------------------------------------------------
---- Company: Department of Electrical and Computer Engineering, University of Alberta
---- Engineer: Ryan Moro
---- 
---- Create Date: 08/31/2020 03:41:32 PM
---- Design Name: sequence detector
---- Module Name: seq_fsm - Behavioral
---- Project Name: Lab 2
---- Target Devices: 
---- Tool Versions: 
---- Description: SEQUENCE DETECTOR : 01101 - OVERLAPPING CASE : MOORE FSM
---- 
---- Dependencies: 
---- 
---- Revision:
---- Revision 0.01 - File Created
---- Additional Comments:
---- 
------------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seq_fsm is
Port (clk           : in std_logic;
      reset         : in std_logic;
      seq_in        : in std_logic;
      output_detect : out std_logic;
      clk_out : out std_logic);
end seq_fsm;

architecture Behavioral of seq_fsm is

signal clk_o : std_logic;

type states is (A,B,C,D,E,F);
signal state_reg, state_next: states;

component clk_divider is
    Port ( clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end component;
  
begin

label_clk_divider: clk_divider port map(clk_in => clk, clk_out => clk_o);  
clk_out <= clk_o;
    process(clk_o, reset) --added reset
        begin
           if(reset='1')then
                state_reg <= A; -- A not B
           elsif(clk_o'event and clk_o='1')then --rising edge clock trigger
                state_reg <= state_next;
           end if; 
    end process;
    
    process(state_reg, seq_in) 
        begin
        case state_reg is
            when A =>
                    output_detect <='0';
                    
                    if seq_in='0' then
                        state_next <= B;
                    else 
                        state_next <= A;
                    end if; 

            when B =>
                    output_detect <='0';
                
                    if seq_in='1' then
                        state_next <= C;
                    else
                        state_next <= B;
                    end if;                    

            when C =>
                    output_detect <='0';

                    if seq_in='1' then
                        state_next <= D;
                    else
                        state_next <= B;
                    end if; 
                    
            when D =>
                    output_detect <='0';
                    
                    if seq_in='0' then
                        state_next <= E;
                    else
                        state_next <= A;
                    end if;          
                    
            when E =>
                    output_detect <='0';
 
                    if seq_in='1' then
                        state_next <= F;
                    else
                        state_next <= B;
                    end if; 
          
            when F =>
                    output_detect <='1';
                    
                    if seq_in='1' then
                        state_next <= D;
                    else
                        state_next <= B;
                    end if;                                                               
        end case;
    end process;
    
end Behavioral;
