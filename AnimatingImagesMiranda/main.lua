-----------------------------------------------------------------------------------------
-- Title: MovingImages
-- Name: Miranda
-- Course: ICS2O
-- This program displays three chararcters and they will all move in different directions. They will
-- fade in or out and grow/shrink in size
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

--global varaiables
scrollSpeed = 3

--display background
local backgroundImage = display.newImageRect("Images/farm.jpg", 1024, 768)
backgroundImage.anchorX = 0
backgroundImage.anchorY = 0

--display sheep and set location
local sheep = display.newImageRect("Images/sheep.png", 170, 170)
sheep.x = 500
sheep.y = 600

-- set sheep to transparent
sheep.alpha = 0

--Funtion: MoveSheep
--Input:this function accepts an event listener
--Output:none
--Description: This function adds the scrollSpeed to the x-value
local function MoveSheep(event)
	-- add the scrollSpeed to the x-value
	sheep.y = sheep.y - scrollSpeed
	-- make the sheep appear
	sheep.alpha = sheep.alpha + 0.1
end

--make it run over and over again
Runtime:addEventListener("enterFrame", MoveSheep)

--display Chicken and set location
local chicken = display.newImageRect("Images/chicken.png", 140 ,140)
chicken.x = 300
chicken.y = 600

--Function 











--display cow and set location
local cow = display.newImageRect("Images/cow.png", 190, 190)
cow.x = 750
cow.y = 600



