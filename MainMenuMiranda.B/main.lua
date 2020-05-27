-----------------------------------------------------------------------------------------
-- Title: SampleVideoGame
-- Name: Miranda.B
-- Course: ICS2O
-- This program...
-----------------------------------------------------------------------------------------

-- Hiding Status Bar
display.setStatusBar(display.HiddenStatusBar)
 
-----------------------------------------------------------------------------------------

-- Use composer library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Go to the intro screen
composer.gotoScene( "splash_screen" )
