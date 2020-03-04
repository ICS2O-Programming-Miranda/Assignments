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

--display sheep
local sheep = display.newImageRect("Images/sheep.png", 160, 160)
sheep.x = 500
sheep.y = 600

--display Chicken
local chicken = display.newImageRect("Images/chicken.png", 200 ,200)
chicken.x = 350
chicken.y = 600

--display cow
local cow = display.newImageRect("Images/cow.png", 180, 180)
cow.x = 750
cow.y = 600