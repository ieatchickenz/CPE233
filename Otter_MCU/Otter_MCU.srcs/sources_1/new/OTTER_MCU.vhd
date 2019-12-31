----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2019 04:32:27 PM
-- Design Name: 
-- Module Name: OTTER_MCU - Behavioral
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

entity OTTER_MCU is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           IOBUS_IN : in STD_LOGIC;
           IOBUS_OUT : out STD_LOGIC;
           IOBUS_ADDR : out STD_LOGIC;
           IOBUS_WR : in STD_LOGIC);
end OTTER_MCU;

architecture Behavioral of OTTER_MCU is

begin


end Behavioral;
