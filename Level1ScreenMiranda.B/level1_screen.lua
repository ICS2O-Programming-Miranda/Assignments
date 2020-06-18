-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by:Miranda.B
-- Date: June 3,2020
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )
local joystick = require( "joystick" )
local physics = require("physics") 


-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level1_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- DECLARATION LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
ChocolateNumber = 0
userLives = 3
lvNumber = 1
restarted = 0
local bkg_image
local analogStick
local facingWhichDirection = "right"
local joystickPressed = false


-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------
--create leve1 bkg sound 
local level1Music = audio.loadSound("Sounds/level1Music.mp3")
local level1MusicChannel

-----------------------------------------------------------------------------------------
-- L0CAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating a function which limits the characters' movement to the visible screen

local function ScreenLimit( character )   

    -- Checking if the the character is about to go off the right side of the screen
    if character.x > ( display.contentWidth - character.width / 2 ) then
            
        character.x = character.x - 7.5

    -- Checking if the character is about to go off the left side of the screen
    elseif character.x < ( character.width / 2 ) then

        character.x = character.x + 7.5

    -----------------------------------------------------------------------------------------

    -- Checking if the character is about to go off the bottom of the screen
    elseif character.y > ( display.contentHeight - character.height / 2 ) then

        character.y = character.y - 7.5

    -- Checking if the character is about to off the top of the screen
    elseif character.y < ( character.height / 2 ) then

        character.y = character.y + 7.5

    end
end
 
local function RuntimeEvents( )

        -- Retrieving the properties of the joystick
        angle = analogStick:getAngle()
        distance = analogStick:getDistance() -- Distance from the center of the joystick background
        direction = analogStick.getDirection()

        -----------------------------------------------------------------------------------------

        -- Checking if the joystick is being held
        if joystickPressed == true then

            -- Applying the force of the joystick to move the cupcakeCharacter
            analogStick:move( cupcakeCharacter, 0.75 )

        end

        -----------------------------------------------------------------------------------------

        -- Limiting each character's movement to the edge of the screen
        ScreenLimit( cupcakeCharacter )

        -----------------------------------------------------------------------------------------

        -- Checking if the joystick is pointing the opposite direction of the character
        if facingWhichDirection == "left" then
            
            -- Checking if the joystick is pointing to the right
            if direction == 1 or direction == 2 or direction == 8 then

                -- Flipping the controlled charcter's direction
                --cupcakeCharacter:scale( -1, 1 )

                -- Setting the status of the character's directions
                facingWhichDirection = "right"

            end
        end

        -----------------------------------------------------------------------------------------

        -- Checking if the joystick is pointing the opposite direction of the character
        if facingWhichDirection == "right" then


            -- Checking if the joystick is pointing to the right
            if direction == 4 or direction == 5 or direction == 6 then

                -- Flipping the controlled charcter's direction
                --cupcakeCharacter:scale( -1, 1 )

                -- Setting the status of the character's directions
                facingWhichDirection = "left"

            end
        end

        -----------------------------------------------------------------------------------------

end -- local function RuntimeEvents( )

-----------------------------------------------------------------------------------
local function AddPhysicsBodies()

    physics.addBody(wall1, "static", {friction = 0})
    physics.addBody(wall2, "static", {friction = 0})
    physics.addBody(wall3, "static", {friction = 0})
    physics.addBody(wall4, "static", {friction = 0})
    physics.addBody(wall5, "static", {friction = 0})
    physics.addBody(wall6, "static", {friction = 0})
    physics.addBody(wall7, "static", {friction = 0})
    physics.addBody(wall8, "static", {friction = 0})
    physics.addBody(wall9, "static", {friction = 0})
    physics.addBody(wall10, "static", {friction = 0})
    physics.addBody(wall11, "static", {friction = 0})
    physics.addBody(wall12, "static", {friction = 0})
    physics.addBody(chocolate1, "static", {friction = 0})
    physics.addBody(chocolate2, "static", {friction = 0})
    physics.addBody(chocolate3, "static", {friction = 0})
    physics.addBody(chocolate4, "static", {friction = 0})
    physics.addBody(cupcakeCharacter, "dynamic", {friction = 0})
    physics.addBody(iceCream, "static", {friction = 0})
end

local function RemovePhysicsBodies()

    physics.removeBody(wall1)
    physics.removeBody(wall2)
    physics.removeBody(wall3)
    physics.removeBody(wall4)
    physics.removeBody(wall5)
    physics.removeBody(wall6)
    physics.removeBody(wall7)
    physics.removeBody(wall8)
    physics.removeBody(wall9)
    physics.removeBody(wall10)
    physics.removeBody(wall11)
    physics.removeBody(wall12)
    physics.removeBody(chocolate1)
    physics.removeBody(chocolate2)
    physics.removeBody(chocolate3)
    physics.removeBody(chocolate4)
    physics.removeBody(cupcakeCharacter)
    physics.removeBody(iceCream)

end

-- Creating Joystick function that determines whether or not joystick is pressed
local function Movement( touch )

    if touch.phase == "began" then

        -- Setting a boolean to true to simulate the holding of a button
        joystickPressed = true

    elseif touch.phase == "ended" then

        -- Setting a boolean to false to simulate the release of a held button
        joystickPressed = false
    end
end --local function Movement( touch )
-----------------------------------------------------------------------------------------



local function onLocalCollision( self, event )

    if ( event.phase == "began" ) then
        --print( self.myName .. ": collision began with " .. event.other.myName )
        print ("*** cupcakeCharacter collision withchocolate1")
        

    elseif ( event.phase == "ended" ) then
        --print( self.myName .. ": collision ended with " .. event.other.myName )
        print ("*** end of cupcakeCharacter collision withchocolate1")
        composer.gotoScene( "Math", {effect = "flipFadeOutIn", time = 500})
        
    end
end

local function onLocalCollisionWithIceCream( self, event )

    if ( event.phase == "began" ) then
        --print( self.myName .. ": collision began with " .. event.other.myName )
        print ("*** cupcakeCharacter collision with iceCream")
        

    elseif ( event.phase == "ended" ) then
        --print( self.myName .. ": collision ended with " .. event.other.myName )
        print ("*** end of cupcakeCharacter collision with iceCream")
        composer.gotoScene( "you_Win", {effect = "flipFadeOutIn", time = 500})
        
    end
end

---------------------------------------------------------------------------------------

-- create the functions to mute and unmute the sound
local function Mute(touch)
    if (touch.phase == "ended")then
     --pause the music
     audio.pause(level1MusicChannel)

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
     audio.resume(level1MusicChannel)

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



-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    ChocolateNumber = 0
    userLives = 3
    -----------------------------------------------------------------------------------------

    -- Insert the background image
    bkg_image = display.newImageRect("Images/GameBkg.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Walls
    wall1 = display.newRect(0, 0,display.contentWidth, 20)
    wall1.x = display.contentCenterX
    wall1.y = 0
    wall1:setFillColor(0, 0, 0)
    wall1:toFront()
    

    wall2 = display.newRect(0, 0,display.contentWidth, 20)
    wall2.x = display.contentCenterX
    wall2.y = display.contentHeight
    wall2:setFillColor(0, 0, 0)
    wall2:toFront()
    

    wall3 = display.newRect(0, 0, 20, display.contentHeight)
    wall3.x = display.contentWidth
    wall3.y = display.contentCenterY
    wall3:setFillColor(0, 0, 0)
    wall3:toFront()
    

    wall4 = display.newRect(0, 0, 20, display.contentHeight)
    wall4.x = 0
    wall4.y = display.contentCenterY
    wall4:setFillColor(0, 0, 0)
    wall4:toFront()
    

    wall5 = display.newRect(0, 0, 10, display.contentHeight - 240)
    wall5.x = 0
    wall5.y = 170
    wall5:rotate(90)
    wall5:setFillColor(0, 0, 0)
    wall5:toFront()
    

    wall6 = display.newRect(0, 0, 10, display.contentHeight - 30)
    wall6.x = 420
    wall6.y = 190
    wall6:setFillColor(0, 0, 0)
    wall6:toFront()
    

    wall7 = display.newRect(0, 0, 10, display.contentHeight - 550)
    wall7.x = 270
    wall7.y = 273
    wall7:setFillColor(0, 0, 0)
    wall7:toFront()
    

    wall8 = display.newRect(0, 0, 10, display.contentHeight - 500)
    wall8.x = 140
    wall8.y = 385
    wall8:rotate(90)
    wall8:setFillColor(0, 0, 0)
    wall8:toFront()
    

    wall9 = display.newRect(0, 0, 198, 10)
    wall9.x = 325
    wall9.y = 560
    wall9:setFillColor(0, 0, 0)
    wall9:toFront()


    wall10 = display.newRect(0, 0, 10, display.contentHeight - 150)
    wall10.x = 600
    wall10.y = 500
    wall10:setFillColor(0, 0, 0)
    wall10:toFront()
    

    wall11 = display.newRect(0, 0, 10, display.contentHeight - 580)
    wall11.x = 690
    wall11.y = 190
    wall11:rotate(90)
    wall11:setFillColor(0, 0, 0)
    wall11:toFront()


    wall12 = display.newRect(0, 0, 10, display.contentHeight - 370)
    wall12.x = 780
    wall12.y = 384
    wall12:setFillColor(0, 0, 0)
    wall12:toFront()

    --Creating the pumpkins.

    -- Creating Joystick
    analogStick = joystick.new( 50, 75 ) 

    -- Setting Position
    analogStick.x = 125
    analogStick.y = display.contentHeight - 125

    -- Changing transparency
    analogStick.alpha = 0.5


  chocolate1 = display.newImageRect("Images/ChocolateBar.png", 130, 140)
  chocolate1.anchorX = 0
  chocolate1.anchorY = 0
  chocolate1.x = 250
  chocolate1.y = 400
   

   chocolate2 = display.newImageRect("Images/ChocolateBar.png", 130, 140)
   chocolate2.anchorX = 0
   chocolate2.anchorY = 0
   chocolate2.x = 410
   chocolate2.y = 600  
   

   chocolate3 = display.newImageRect("Images/ChocolateBar.png", 130, 140)
   chocolate3.anchorX = 0
   chocolate3.anchorY = 0
   chocolate3.x = 800
   chocolate3.y = 30
   

  chocolate4 = display.newImageRect("Images/ChocolateBar.png", 130, 140)
  chocolate4.anchorX = 0
  chocolate4.anchorY = 0
  chocolate4.x = 840
  chocolate4.y = 600

-----------------------------------------------------------------
--Adding in the character.

    cupcakeCharacter = display.newImageRect("Images/CupcakeCharacter.png", 100, 100)
    cupcakeCharacter.anchorX = 0
    cupcakeCharacter.anchorY = 0 
    cupcakeCharacter.x = 60
    cupcakeCharacter.y = 20
    

-----------------------------------------------------------------
-- Adding in the iceCream.

   iceCream = display.newImageRect("Images/IceCream.png", 170, 170)
   iceCream.anchorX = 0
   iceCream.anchorY = 0
   iceCream.x = 610
   iceCream.y = 260 

    -- add collision event listeners
    cupcakeCharacter.collision = onLocalCollision
    cupcakeCharacter:addEventListener( "collision", cupcakeCharacter)

    chocolate2.collision = onLocalCollision
    chocolate2:addEventListener( "collision", chocolate2 ) 

    chocolate3.collision = onLocalCollision
    chocolate3:addEventListener( "collision", chocolate3 )

   chocolate4.collision = onLocalCollision
   chocolate4:addEventListener( "collision",chocolate4 ) 

   chocolate1.collision = onLocalCollision
   chocolate1:addEventListener( "collision",chocolate1 )

    iceCream.collision = onLocalCollisionWithIceCream
    iceCream:addEventListener( "collision", iceCream ) 

    -----------------------------------------------------------------------------------------
    --CREATE MUTE AND UNMUTE BUTTONS 
    -----------------------------------------------------------------------------------------

    --create the mute and unmute button 
    muteButton = display.newImageRect ("Images/MuteButton.png", 100, 100)
    muteButton.x = 140
    muteButton.y = 280
    muteButton.isVisible = false


    unmuteButton = display.newImageRect ("Images/UnmuteButton.png", 100, 100)
    unmuteButton.x = 140
    unmuteButton.y = 280
    unmuteButton.isVisible = true

    ----------------------------------------------------------------------------------------------
    
    -- Send the background image to the back layer so all other objects can be on top
    

        -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )
    sceneGroup:insert( analogStick )   
    sceneGroup:insert(chocolate1 ) 
    sceneGroup:insert( chocolate2 ) 
    sceneGroup:insert( chocolate3 )
    sceneGroup:insert(chocolate4 )
    sceneGroup:insert( iceCream )
    sceneGroup:insert( cupcakeCharacter )
    sceneGroup:insert( wall1 )
    sceneGroup:insert( wall2 )
    sceneGroup:insert( wall3 )
    sceneGroup:insert( wall4 )
    sceneGroup:insert( wall5 )
    sceneGroup:insert( wall6 )
    sceneGroup:insert( wall7 )
    sceneGroup:insert( wall8 )
    sceneGroup:insert( wall9 )
    sceneGroup:insert( wall10 )
    sceneGroup:insert( wall11 )
    sceneGroup:insert( wall12 )
    sceneGroup:insert( muteButton )
    sceneGroup:insert( unmuteButton ) 

end --function scene:create( event )
-----------------------------------------------------------------

-----------------------------------------------------------------------------------------------
-- The function called when the scene is issued to appear on screen
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        if (restarted == 1) then

            scene:create()
            restarted = 0
        end
        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.

       if(soundOn == true) then
         --play bkg music only on level 1 screen
         level1MusicChannel = audio.play(level1Music, {loops = -1})
         muteButton.isVisible = false
         unmuteButton.isVisible = true

        elseif (soundOn == false) then 
         audio.pause(level1MusicChannel)
         muteButton.isVisible = true
         unmuteButton.isVisible = false
        end

        --add mute and unmute functionality to the buttons
        AddMuteUnMuteListeners()
        AddUNMuteMuteListeners()

        if (ChocolateNumber == 1) then

           chocolate1.x = -250
           chocolate1.y = -250
           chocolate1.collision = offLocalCollision
           chocolate1:removeEventListener( "collision",chocolate1 )

        end

        if (ChocolateNumber == 2) then

            chocolate2.x = -250
            chocolate2.y = -250
            chocolate2.collision = offLocalCollision
            chocolate2:removeEventListener( "collision", chocolate2 )

        end

        if (ChocolateNumber == 3) then

            chocolate3.x = -250
            chocolate3.y = -250
            chocolate3.collision = offLocalCollision
            chocolate3:removeEventListener( "collision", chocolate3 )

        end

        if (ChocolateNumber == 4) then

           chocolate4.x = -250
           chocolate4.y = -250
           chocolate4.collision = offLocalCollision
           chocolate4:removeEventListener( "collision",chocolate4 )

        end

               
        -- start the physics engine
        physics.start()
        physics.setGravity( 0, 0 )

        -- activate the joystick
        AddPhysicsBodies()
        analogStick:activate()

        -----------------------------------------------------------------------------------------
        -- EVENT LISTENERS
        -----------------------------------------------------------------------------------------

        -- Listening for the usage of the joystick
        analogStick:addEventListener( "touch", Movement )
        Runtime:addEventListener("enterFrame", RuntimeEvents)



    end

end  --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase


    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.



    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.

                -- Deactivating the Analog Stick
        analogStick:deactivate()

        -- Stopping the Runtime Events
        Runtime:removeEventListener( "enterFrame", RuntimeEvents )

        -- Removing the listener which listens for the usage of the joystick
        analogStick:removeEventListener( "touch", Movement )

        cupcakeCharacter:removeEventListener( "collision", cupcakeCharacter)
       chocolate1:removeEventListener( "collision",chocolate1 )
        RemovePhysicsBodies()
        -- start the physics engine
        physics.stop()

        --stop bkg music
        audio.stop(level1MusicChannel)

        RemoveMuteUnMuteListeners()
        RemoveUnMuteMuteListeners()
        
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

--Runtime:addEventListener("enterFrame", CheckCollisions)
 --Runtime:addEventListener("enterFrame",  movePumpkin1 )




-----------------------------------------------------------------------------------------

return scene

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------