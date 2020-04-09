-----------------------------------------------------------------------------------------
-- Title: Math Quiz
-- Name: Miranda.b
-- Course: ICS2O
-- This program displays a question for the user to answer. The question is randomly
--generated. If the user gets the answer wrong or the timer runs out, one life is lost
-- and the correct answer is displayed. If the user gets 5 correct a "you win" will be 
--displayed else a "game over " is displayed. 
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

--set background colour
display.setDefault("background",247/255, 238/255, 180/255 )

------------------------------------------------------------------------------
--LOCAL VARIABLES
-------------------------------------------------------------------------------
local questionObject
local correctobject
local incorrectObject
local NumericTextFields
local randomNumber1
local randomNumber2
local randomOperator
local userAnswer
local correctAnswer 
local incorrectanswer
local totalSeconds = 11
local secondsLeft = 11
local clockText 
local countDownTimer
local lives = 3
local heart1
local heart2
local heart3
local numCorrectObject
local numCorrect = 0
local gameOver
local youWin
local temp
local correctionText
local correctionAnswer = correctAnswer
--------------------------------------------------------------------------------
--SOUNDS
--------------------------------------------------------------------------------
-- create the correct noise
local correctSound = audio.loadSound("Sounds/yaysound.mp3")
local correctSoundChannel

--create the incorrect noise
local incorrectSound = audio.loadSound("Sounds/boosound.wav")
local incorrectSoundChannel

--create you win Sound
local youWinSound = audio.loadSound("Sounds/youwin.wav")
local youWinSoundChannel

--create the game over Sound
local gameOverSound = audio.loadSound("Sounds/game over.wav")
local gameOverSoundChannel

--create and play background music
local backgroundMusic = audio.loadSound("Sounds/Background music.mp3")
local backgroundMusicChannel
backgroundMusicChannel = audio.play(backgroundMusic)
-----------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------
local function AskQuestion()
	-- generate a random number between 1 and 4
	randomOperator = math.random(1,4)


	--if the random operator is 1, then do addition
	if (randomOperator == 1) then
		randomNumber1 = math.random(1,20)
		randomNumber2 = math.random(1,20)

		--calculate the correct answer
		correctAnswer = randomNumber1 + randomNumber2

		--create question in text Object
		questionObject.text = randomNumber1 .. "+" .. randomNumber2 .. "="

		--otherwise, if random operator is 2, then do subtraction
	elseif(randomOperator == 2) then
		randomNumber1 = math.random(1,20)
		randomNumber2 = math.random(1,20)

		--calculate the correct answer
		correctAnswer = randomNumber1 - randomNumber2

		--create question in text Object
		questionObject.text = randomNumber1 .. "-" .. randomNumber2 .. "="

		--otherwise, if random operator is 3, then do multiplication
	elseif(randomOperator == 3) then
		randomNumber1 = math.random(1,10)
		randomNumber2 = math.random(1,10)

		--calculate the correct answer
		correctAnswer = randomNumber1 * randomNumber2

		--create question in text Object
		questionObject.text = randomNumber1 .. "*" .. randomNumber2 .. "="

	 	--otherwise, if random operator is 4, then do divison
	elseif(randomOperator == 4) then
		randomNumber1 = math.random(1,100)
		randomNumber2 = math.random(1,100)

		--calculate the correct answer
		correctAnswer = randomNumber1 * randomNumber2

		temp = randomNumber1
		randomNumber1 = correctAnswer
		correctAnswer = temp

		correctAnswer = randomNumber1 / randomNumber2

		--create question in text Object
		questionObject.text = randomNumber1 .. "/" .. randomNumber2 .. "="
	end

end

local function HideCorrect()
	correctobject.isVisible = false
	AskQuestion()
end

local function HideIncorrect()
	incorrectObject.isVisible = false
	AskQuestion()
end

local function NumericFieldListener( event )
	-- user begins editing "numericField"
	if (event.phase == "began") then
		-- clear text field 
		event.target.text = ""

	elseif (event.phase == "submitted") then  
		--when the answer is submitted (enter key is pressed) set user input to user's answer
		userAnswer = tonumber(event.target.text)

		--if the user answers and the correct answer are the same:
		if (userAnswer == correctAnswer) then 
			correctobject.isVisible = true
			timer.performWithDelay(3000, HideCorrect)
			correctSoundChannel = audio.play(correctSound)
			numCorrect = numCorrect + 1
			numCorrectObject.text = "Correct Answers: " .. numCorrect 
		else 
			incorrectObject.isVisible = true
			timer.performWithDelay(3000,HideIncorrect)
			incorrectSoundChannel = audio.play(incorrectSound)
			lives = lives-1
			correctionText.isVisible = true

		end

		--clear text field
		event.target.text = ""
	end
end

local function UpdateTime()
	-- decrement the number of seconds 
	secondsLeft = secondsLeft - 1

	--display the number of seconds left in the clock object
	clockText.text = "Time Remaining: " ..secondsLeft.. "" 

	if (secondsLeft == 0) then
		--reset the number of seconds left
		secondsLeft = totalSeconds

		--if time runs out a life is taken away
		lives = lives - 1

		if (lives == 2) then
			heart3.isVisible = false
		elseif (lives == 1) then
			heart2.isVisible = false
		elseif(lives == 0) then
			heart1.isVisible = false
			questionObject.isVisible = false
			numericField.isVisible = false
			clockText.isVisible = false
			gameOver.isVisible = true
			timer.cancel(StartTimer)
			gameOverSoundChannel = audio.play(gameOverSound)
		end

		AskQuestion()
	end

end

local function StartTimer()
	-- create a countdown timer that loops infinitely
	countDownTimer = timer.performWithDelay(1000,UpdateTime, 0 )

end

if (numCorrect == 5) then
	youWin.isVisible = true
	questionObject.isVisible = false
	numericField.isVisible = false
	clockText.isVisible = false
	timer.cancel(StartTimer)
	youWinSoundChannel = audio.play(youWinSound)
end

-------------------------------------------------------------------------------
--OBJECT CREATION
-------------------------------------------------------------------------------

-- display a question and set its colour
questionObject = display.newText("", display.contentWidth/2, display.contentHeight/2, nil, 70)
questionObject:setTextColor(226/255, 74/255, 74/255)

--create the correct text and make it invisible
correctobject = display.newText("Correct!", display.contentWidth/2, display.contentHeight*1/3, nil, 50)
correctobject:setTextColor(152/255, 251/255, 152/255)
correctobject.isVisible = false

--create the incorrect text and make it invisible
incorrectObject = display.newText("Incorrect", display.contentWidth/2, display.contentHeight*1/3,nil, 50)
incorrectObject:setTextColor(245/255, 99/255, 99/255)
incorrectObject.isVisible = false

--create numeric field 
numericField = native.newTextField(display.contentWidth/2, display.contentHeight*2/3, 200, 100)
numericField.inputType = "numbers"

--add the event listener for the numeric field
numericField:addEventListener("userInput", NumericFieldListener)

--create the clock and display the amount of time 
clockText = display.newText("Time Remaining: " .. secondsLeft, display.contentWidth*2/8, display.contentHeight*1/7,nil, 50)
clockText:setTextColor(226/255, 74/255, 74/255)

--create the lives
heart1 = display.newImageRect("Images/heart.png", 100, 100)
heart1.x = display.contentWidth*7/8
heart1.y = display.contentHeight*1/7

heart2 = display.newImageRect("Images/heart.png", 100, 100)
heart2.x = display.contentWidth*6/8
heart2.y = display.contentHeight*1/7

heart3 = display.newImageRect("Images/heart.png", 100, 100)
heart3.x = display.contentWidth*5/8
heart3.y = display.contentHeight*1/7

--create game over screen
gameOver = display.newImageRect("Images/game over.png", 500, 500)
gameOver.x = display.contentWidth/2
gameOver.y = display.contentHeight/2
gameOver.isVisible = false

--create you win screen
youWin = display.newImageRect("Images/you win.png", 500, 500)
youWin.x = display.contentWidth/2
youWin.y = display.contentHeight/2
youWin.isVisible = false

--create the object that shows the number of correct answers
numCorrectObject = display.newText("Correct Answers: " ..numCorrect ,display.contentWidth/2, display.contentHeight*2/5, nil, 50)
numCorrectObject:setTextColor(226/255, 74/255, 74/255)

--create correction text
correctionText = display.newText("The correct answer is "..correctionAnswer, display.contentWidth/2, display.contentHeight*4/5, nil ,50)
correctionText:setTextColor(226/255, 74/255, 74/255)
correctionText.isVisible = false
--------------------------------------------------------------------------------
--CALL FUNCTIONS
--------------------------------------------------------------------------------
AskQuestion()
UpdateTime()
StartTimer()