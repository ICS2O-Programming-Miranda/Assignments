-----------------------------------------------------------------------------------------
--
-- main_menu.lua
-- Created by: Miranda.B 
-- Date: May 25,2020
-- Description: This is the main menu, displaying the credits, instructions & play buttons.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "main_menu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image
local playButton
local creditsButton
local instructionsButton

-----------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
-----------------------------------------------------------------------------------------

soundOn = true

-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------
--create the Sounds
local bkgMusic = audio.loadSound("Sounds/background music.mp3")
local bkgMusicChannel

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transition Function to Credits Page
local function CreditsTransition( )       
    composer.gotoScene( "credits_screen", {effect = "zoomInOutRotate", time = 1000})
end 

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level1ScreenTransition( )
    composer.gotoScene( "level1_screen", {effect = "fromTop", time = 1000})
end    

-------------------------------------------------------------------------------------------

-- Creating Transition to Instructions Screen
local function InstructionsTransition( )
    composer.gotoScene( "instructions", {effect = "flipFadeOutIn", time = 1000})
end  

-------------------------------------------------------------------------------------------

-- create the functions to mute and unmute the sound
local function Mute(touch)
    if (touch.phase == "ended")then
     --pause the music
     audio.pause(bkgMusicChannel)

     --Turn the sound variable off
     soundOn = false

     --make unmute button invisible and mute button visible
     muteButton.isVisible = true
     unmuteButton.isVisible = false 
    end
end

local function AddMuteUnMuteListeners()
    unmuteButton:addEventListener("touch", Mute)
end

local function RemoveMuteUnMuteListeners()
    unmuteButton:removeEventListener("touch", Mute)
end

local function UnMute(touch)
    if (touch.phase == "ended")then
     --play the music
     audio.resume(bkgMusicChannel)

     --Turn the sound variable on
     soundOn = true

     --make unmute button visible and mute button invisible
     muteButton.isVisible = false
     unmuteButton.isVisible = true
    end 
end

local function AddUNMuteMuteListeners()
    muteButton:addEventListener("touch", UnMute)
end

local function RemoveUnMuteMuteListeners()
    muteButton:removeEventListener("touch", UnMute)
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/MainMenu.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight


    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    playButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1/8,
            y = display.contentHeight*3/8,

            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/Play Button Unpressed.png",
            overFile = "Images/Play Button Pressed.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition          
        } )

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1/8,
            y = display.contentHeight*7/8,

            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/Credits Button Unpressed.png",
            overFile = "Images/Credits Button Pressed.png",

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
        } ) 
    
    ----------------------------------------------------------------------------------------------
        -- Creating Instructions Button
    instructionsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1/8,
            y = display.contentHeight*5/8,


            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/Instructions Button Unpressed.png",
            overFile = "Images/Instructions Button Pressed.png",

            -- When the button is released, call the Credits transition function
            onRelease = InstructionsTransition
        } ) 
    

    -----------------------------------------------------------------------------------------
    --CREATE MUTE AND UNMUTE BUTTONS 
    -----------------------------------------------------------------------------------------

    --create the mute and unmute button 
    muteButton = display.newImageRect ("Images/MuteButton.png", 100, 100)
    muteButton.x = 950
    muteButton.y = 700
    muteButton.isVisible = false

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( muteButton )

    unmuteButton = display.newImageRect ("Images/UnmuteButton.png", 100, 100)
    unmuteButton.x = 950
    unmuteButton.y = 700
    unmuteButton.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( unmuteButton )




    -----------------------------------------------------------------------------------------
    -- Associating button widgets with this scene
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( instructionsButton )
    

end -- function scene:create( event )   



-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).   
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    elseif ( phase == "did" ) then       
     
     if(soundOn == true) then
         --play bkg music only on level 1 screen
         bkgMusicChannel = audio.play(bkgMusic, {loops = -1})
         muteButton.isVisible = false
         unmuteButton.isVisible = true

        elseif (soundOn == false) then 
         audio.pause(bkgMusicChannel)
         muteButton.isVisible = true
         unmuteButton.isVisible = false
        end

        --add mute and unmute functionality to the buttons
        AddMuteUnMuteListeners()
        AddUNMuteMuteListeners()


    end

end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.

        --stop bkg music
        audio.stop(bkgMusicChannel)

        RemoveMuteUnMuteListeners()
        RemoveUnMuteMuteListeners()
    end

end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.

end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
