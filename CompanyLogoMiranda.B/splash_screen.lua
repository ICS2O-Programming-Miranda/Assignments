-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by:Miranda.B
-- Date: May 25, 2020
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local littlePinkFlower
local littleBlueFlower
local bigBlueFlower
local bigRedFlower

local logoText

local background
----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------
local splashScreenSound = audio.loadSound("Sounds/Splash screen sound.wav")
local SplashScreenSoundsChannel

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- The function that moves the littlePinkFlower across the screen
local function movelittlePinkFlower()
    --set scroll speed
    local scrollXSpeed = 4
    local scrollYSpeed = -2

    littlePinkFlower.x = littlePinkFlower.x - scrollXSpeed
    littlePinkFlower.y = littlePinkFlower.y + scrollYSpeed
    -- make the littlePinkFlower fade out
    littlePinkFlower.alpha = littlePinkFlower.alpha + 0.01

    --make it rotate
    littlePinkFlower:rotate(3)

end

local function movelittleBlueFlower()
    --set scroll speed
    local scrollXSpeed = 4
    local scrollYSpeed = 2

    littleBlueFlower.x = littleBlueFlower.x + scrollXSpeed
    littleBlueFlower.y = littleBlueFlower.y + scrollYSpeed
     -- make the littlePinkFlower fade out
    littleBlueFlower.alpha = littleBlueFlower.alpha + 0.01

    --make it rotate
    littleBlueFlower:rotate(3)

end

local function movebigBlueFlower()
    --set scroll speed
    local scrollXSpeed = 4
    local scrollYSpeed = -2

    bigBlueFlower.x = bigBlueFlower.x + scrollXSpeed
    bigBlueFlower.y = bigBlueFlower.y + scrollYSpeed

end

local function movebigRedFlower()
    --set scroll speed
    local scrollXSpeed = 4
    local scrollYSpeed = 2

    bigRedFlower.x = bigRedFlower.x - scrollXSpeed
    bigRedFlower.y = bigRedFlower.y + scrollYSpeed

end

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu", {effect = "crossFade", time = 1000})
end


----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    --set background
    background = display.newImageRect("Images/background.png", 1024, 768)
    background.anchorX = 0
    background.anchorY = 0

    -- Insert the littlePinkFlower image
    littlePinkFlower = display.newImageRect("Images/littlePinkFlower.png", 150, 150)

    -- set the initial x and y position of the littlePinkFlower
    littlePinkFlower.x = 1024
    littlePinkFlower.y = 768

    --set littlePinkFlower to invisible
    littlePinkFlower.alpha = 0

    --create little blue flowerr
    littleBlueFlower = display.newImageRect("Images/littleBlueFlower.png", 150, 150)

    --set initial x and y position
    littleBlueFlower.x = 0
    littleBlueFlower.y = 0
    --set littleBlueFlower to invisible
    littleBlueFlower.alpha = 0

    --create big blue flowerr
    bigBlueFlower = display.newImageRect("Images/bigBlueflower.png", 200, 200)

    --set initial x and y position
    bigBlueFlower.x = 0
    bigBlueFlower.y = 768


     --create big red flower
    bigRedFlower = display.newImageRect("Images/bigredFlower.png", 200, 200)

    --set initial x and y position
    bigRedFlower.x = 1024
    bigRedFlower.y = 0

    logoText = display.newImageRect("Images/logoText.png", 600,200)
    logoText.x = display.contentWidth/2
    logoText.y = display.contentHeight/2



    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( background )
    sceneGroup:insert( littlePinkFlower )
    sceneGroup:insert( littleBlueFlower )
    sceneGroup:insert( bigBlueFlower )
    sceneGroup:insert( bigRedFlower )
    sceneGroup:insert( logoText)


end -- function scene:create( event )

--------------------------------------------------------------------------------------------

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

    elseif ( phase == "did" ) then
        -- play  the splash screen music
        SplashScreenSoundsChannel = audio.play(splashScreenSound )

        -- Call the littlePinkFlower function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", movelittlePinkFlower)

        -- Call the littleBlueFlower function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", movelittleBlueFlower)

        -- Call the bigBlueFlower function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", movebigBlueFlower)

        -- Call the bigBlueFlower function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", movebigRedFlower)


        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 3000, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the jungle sounds channel for this screen
        audio.stop(SplashScreenSoundsChannel)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


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
