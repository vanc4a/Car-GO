local composer = require( "composer" )
 
local scene = composer.newScene()

function scene:create( event )
 
    local sceneGroup = self.view
   moveSound = audio.loadSound("moveSound.wav")
crashSound = audio.loadSound("crashSound.wav")
physics = require("physics")
physics.start()
physics.setGravity(0,0)
bg = display.newRect(_X,_Y,_W,_H)
bg:setFillColor(0.0,0.29,0.33)
appodeal.show( "banner", { yAlign="top" } )
markup = display.newRect(_W/1.5,_Y,_W/60,_H)
markup2 = display.newRect(_W/3,_Y,_W/60,_H)
markup:setFillColor(0,0.7,0.6)
markup2:setFillColor(0,0.7,0.64)
markup.alpha = 0.05
markup2.alpha = 0.05
car = display.newRoundedRect(_X,_H/1.15,_W/5,_H/5,_W/30)
car:setFillColor(0.40,0,1)
car.strokeWidth = 2
car:setStrokeColor(0,0,0)
coinStats = 0
physics.addBody(car,"static")
button = display.newRect(_X,_Y,_W/3,_H)
button:setFillColor(1,1,1)
button.alpha = 0.01
button2 = display.newRect(_W/6,_Y,_W/3,_H)
button2:setFillColor(0,0,1)
button2.alpha = 0.01
button3 = display.newRect(_W/1.2,_Y,_W/3,_H)
button3:setFillColor(0,0,0)
button3.alpha = 0.01
appodeal.load("interstitial")
function move(event)
    if(event.phase == "began")then
        transition.to(car,{time = 300,x = event.target.x}) 
        if(car.x > event.target.x)then
            car.rotation = -15
            soundPlayMove()
        elseif(car.x < event.target.x)then
            car.rotation = 15
            soundPlayMove()
        end    
    end
    
    timer.performWithDelay(250,stopRotate,1)
end
function stopRotate()
    car.rotation = 0
end 
function soundPlayMove()
    if(speakerStatus == true)then
        audio.play(moveSound)
    end
end 
function soundPlayCrash()
    if(speakerStatus == true)then
        audio.play(crashSound)
    end
end 
button:addEventListener("touch",move)
button2:addEventListener("touch",move)
button3:addEventListener("touch",move)
speed = 1500
goal = _H + (_W/5)
score = 0
speakerStatus = true
function spawn()
        posNum = math.random(1,3)

        if(posNum == 1) then
        	leftMargin = _X
    	elseif(posNum == 2) then
    		leftMargin = _W/6
    	elseif(posNum == 3) then
    		leftMargin = _W/1.2
		end

        stop = display.newRoundedRect(leftMargin, 0 - (_W/10),_W/5,_W/5,_W/30)
        stop:setFillColor(0.65,0.16,0.16)
        stop.strokeWidth = 2
        stop:setStrokeColor(0,0,0)      
        physics.addBody(stop)
        transition.to(stop,{time = speed,y = goal})

        speedLimit()
        
end
timerSpawn = 800
timeSpawn = timer.performWithDelay(timerSpawn,spawn,0)
border = display.newRect(_X,_H + (_W/10),_W,1)
physics.addBody(border,"static")
function speedLimit()
    if(speed > 300)then
        speed = speed - 10
        
    end
end

function crash(event)
    if(event.phase == "began")then
        
        timer.pause(timeSpawn)
        overGame()
    end 
end
car:addEventListener("collision",crash)
function remove(event)
    if(event.phase == "began")then
        score = score + 1
        scoreText.text = score
        
        event.other:removeSelf()
        
      
        
    end
end
border:addEventListener("collision",remove)  
options = {
    text = score,
    x = _X,
    y = _H/4,
    fontSize = _H/10,
    
}

scoreText = display.newText(options)
adTimer = 0
function addViewer()
    if(adTimer >= 4)then
    appodeal.show( "interstitial" )
    adTimer = 0
    end
end
bestScore = 0
function overGame()
    soundPlayCrash()
    car:removeEventListener("collision",crash)
    button:removeEventListener("touch",move)
    button2:removeEventListener("touch",move)
    button3:removeEventListener("touch",move)
    adTimer = adTimer + 1
    addViewer()
    bestScores()
    result = math.floor(score/10)
    options2 = {
    text = score,
    x = _X,
    y = _H/3,
    fontSize = _H/10,
    
}
    options3 = {
    text ="REPLAY",
    x = _X,
    y = _H/2.15,
    fontSize = _H/18,
    
}
    options4 = {
    text ="BEST SCORE "..bestScore,
    x = _X,
    y = _H/6,
    fontSize = _H/25,
    
}
    bgScore = display.newRoundedRect(_X,_H/3,_W/2,_H/7,_W/40)
    bgScore:setFillColor(0.84,0.43,0)
    bgScore.strokeWidth = 2
    bgScore:setStrokeColor(0,0,0)
    scoreText.alpha = 0
    scoreOver = display.newText(options2)
    buttonRestart = display.newRoundedRect(_X,_H/2.15,_W/2,_H/10,_W/40)
    buttonRestart:setFillColor(0.09,0.1,0.12)
    buttonRestart.strokeWidth = 2
    buttonRestart:setStrokeColor(0,0,0)
    restartText = display.newText(options3)
    bestScoreText = display.newText(options4)
    buttonRestart:addEventListener("tap",restart)
    coinStats = coinStats + result
    options5 = {
    text =coinStats,
    x = _W/2.70,
    y = _H/1.75,
    fontSize = _H/21,
    
}   
    coinText = display.newText(options5)
    result = 0
    coin = display.newCircle(_W/3.5,_H/1.75,_W/30)
    coin.strokeWidth = 1
    coin:setStrokeColor(0,0,0)
    coin:setFillColor(1,0.84,0)
    colorButton = display.newCircle(_W/2,_H/1.75,_W/20)
    colorButton.strokeWidth = 2
    colorButton:setStrokeColor(0,0,0)
    colorButton:setFillColor(0.84,0.43,0.0)
    icon = display.newRoundedRect(_W/2,_H/1.75,_W/24,_H/24,_W/100)
    icon:setFillColor(0.84,0.43,0.0)
    icon.strokeWidth = 2
    icon:setStrokeColor(0,0,0)
    colorButton:addEventListener("tap",colorPanel)
    speakerButton = display.newCircle(_W/1.5,_H/1.75,_W/20)
    speakerButton.strokeWidth = 2
    speakerIconChange()
    speakerButton:setStrokeColor(0,0,0)
    speakerButton:setFillColor(0.84,0.43,0.0)
    speakerButton:addEventListener("tap",speakerStatusChange)
    speakerButton:addEventListener("tap",speakerIconChange)
end
bestScore = 0
function speakerStatusChange()
    if(speakerStatus == true)then
    speakerStatus = false
    elseif(speakerStatus == false)then
    speakerStatus = true
    speakerIcon.alpha = 0
    end
end
function speakerIconChange()
    if(speakerStatus == false)then
    speakerIcon.alpha = 0
    speakerIcon = display.newImage("speakerOff.png")
    speakerIcon.x = _W/1.49
    speakerIcon.y = _H/1.75
    speakerIcon.width = _W/12
    speakerIcon.height = _W/12
    elseif(speakerStatus == true)then   
    speakerIcon = display.newImage("speakerOn.png")
    speakerIcon.x = _W/1.49
    speakerIcon.y = _H/1.75
    speakerIcon.width = _W/12
    speakerIcon.height = _W/12
    end
end

function restart()
    transition.to(car,{time = 300,x = _X,y = _H/1.15})
    car:addEventListener("collision",crash)
    button:addEventListener("touch",move)
    button2:addEventListener("touch",move)
    button3:addEventListener("touch",move)
    colorButton.alpha = 0
    coin.alpha = 0
    icon.alpha = 0
    bestScoreText.alpha = 0
    bgScore.alpha = 0
    scoreText.alpha = 1
    scoreOver.alpha = 0
    buttonRestart.alpha = 0
    restartText.alpha = 0
    coinText.alpha = 0
    speakerButton.alpha = 0 
    speakerIcon.alpha = 0
    speed = 1500
    score = 0
    timer.resume(timeSpawn)
    scoreText.text = score
    removerColorPanel()
end
function bestScores()
    if(score > bestScore)then
    bestScore = score   
    end
end
    buttonStatus2 = false
    buttonStatus3 = false
    buttonStatus4 = false
    buttonStatus5 = false
    buttonStatus6 = false
function colorPanel()
    colorButton:removeEventListener("tap",colorPanel)
    bestScoreText.alpha = 0
    transition.to(car,{time = 600,x = _X,y = _H/8})
    bgColorPanel = display.newRoundedRect(_X,_H/1.3,_W/1.2,_H/3.3,_W/30)
    bgColorPanel:setFillColor(0.27,0.22,0.29)
    bgColorPanel.strokeWidth = 2
    bgColorPanel:setStrokeColor(0,0,0)
    bgColorPanelStatus = true
    buttonChange = display.newRoundedRect(_X/2,_H/1.4,_W/7,_W/7,_H/30)
    buttonChange:setFillColor(0.40,0,1)

    buttonChange2 = display.newRoundedRect(_X,_H/1.4,_W/7,_W/7,_H/30)
    buttonChange2:setFillColor(0.95,0.23,0.07)

    buttonChange3 = display.newRoundedRect(_W/1.35,_H/1.4,_W/7,_W/7,_H/30)
    buttonChange3:setFillColor(0.23,0.46,0.77)

    buttonChange4 = display.newRoundedRect(_X/2,_H/1.2,_W/7,_W/7,_H/30)
    buttonChange4:setFillColor(0.1,0.75,0.24)

    buttonChange5 = display.newRoundedRect(_X,_H/1.2,_W/7,_W/7,_H/30)
    buttonChange5:setFillColor(0.79,0.22,0.40)

    buttonChange6 = display.newRoundedRect(_W/1.35,_H/1.2,_W/7,_W/7,_H/30)
    buttonChange6:setFillColor(0.10,0.09,0.18)

    
    controlColorStatus()
    function color1()
        car:setFillColor(0.40,0,1)
    end
    function color2()
        if(buttonStatus2 == false)then
        buyColors2()
        elseif(buttonStatus2 == true)then
        car:setFillColor(0.95,0.23,0.07)
        end 
    
    end
    function color3()
    if(buttonStatus3 == false)then
        buyColors3()
        elseif(buttonStatus3 == true)then
        car:setFillColor(0.23,0.46,0.77)
        end 
        
    end
    function color4()
        if(buttonStatus4 == false)then
        buyColors4()
        elseif(buttonStatus4 == true)then
        car:setFillColor(0.1,0.75,0.24)
        end 
    end
    function color5()
        if(buttonStatus5 == false)then
        buyColors5()
        elseif(buttonStatus5 == true)then
        car:setFillColor(0.79,0.22,0.40)
        end     
    end
    function color6()
        if(buttonStatus6 == false)then
        buyColors6()
        elseif(buttonStatus6 == true)then
        car:setFillColor(0.10,0.09,0.18)
        end 
    end

    buttonChange:addEventListener("tap",color1)
    buttonChange2:addEventListener("tap",color2)
    buttonChange3:addEventListener("tap",color3)
    buttonChange4:addEventListener("tap",color4)
    buttonChange5:addEventListener("tap",color5)
    buttonChange6:addEventListener("tap",color6)
end
options6 = {
    text ="LOCK",
    x = _X,
    y = _H/1.4,
    fontSize = _H/35,
}
options7 = {
    text ="LOCK",
    x = _W/1.35,
    y = _H/1.4,
    fontSize = _H/35,
}
options8 = {
    text ="LOCK",
    x = _X/2,
    y = _H/1.2,
    fontSize = _H/35,
}
options9 = {
    text ="LOCK",
    x = _X,
    y = _H/1.2,
    fontSize = _H/35,
}
options10 = {
    text ="LOCK",
    x = _W/1.35,
    y = _H/1.2,
    fontSize = _H/35,
}
function removerColorPanel()
    if(bgColorPanelStatus == true)then
    bgColorPanel.alpha = 0
    buttonChange.alpha = 0
    buttonChange2.alpha = 0
    buttonChange3.alpha = 0
    buttonChange4.alpha = 0
    buttonChange5.alpha = 0
    buttonChange6.alpha = 0
    TextStatus2.alpha = 0
    TextStatus3.alpha = 0
    TextStatus4.alpha = 0
    TextStatus5.alpha = 0
    TextStatus6.alpha = 0
    end
end
function controlColorStatus()
    if(buttonStatus2 == false)then
    buttonChange2.alpha = 0.5
    TextStatus2 = display.newText(options6)
    end
    if(buttonStatus3 == false)then
    buttonChange3.alpha = 0.5
    TextStatus3 = display.newText(options7)
    end
    if(buttonStatus4 == false)then
    buttonChange4.alpha = 0.5
    TextStatus4 = display.newText(options8)
    end
    if(buttonStatus5 == false)then
    buttonChange5.alpha = 0.5
    TextStatus5 = display.newText(options9)
    end
    if(buttonStatus6 == false)then
    buttonChange6.alpha = 0.5
    TextStatus6 = display.newText(options10)
    end
end
function buyColors2()
    if(coinStats >= 10)then
    coinStats = coinStats - 10
    buttonStatus2 = true 
    TextStatus2.alpha = 0
    buttonChange2.alpha = 1
    coinText.text = coinStats
    end
end
function buyColors3()
    if(coinStats >= 10)then
    coinStats = coinStats - 10
    buttonStatus3 = true 
    TextStatus3.alpha = 0
    buttonChange3.alpha = 1
    coinText.text = coinStats
    end
end
function buyColors4()
    if(coinStats >= 10)then
    coinStats = coinStats - 10
    buttonStatus4 = true 
    TextStatus4.alpha = 0
    buttonChange4.alpha = 1
    coinText.text = coinStats
    end
end
function buyColors5()
    if(coinStats >= 10)then
    coinStats = coinStats - 10
    buttonStatus5 = true 
    TextStatus5.alpha = 0
    buttonChange5.alpha = 1
    coinText.text = coinStats
    end
end
function buyColors6()
    if(coinStats >= 10)then
    coinStats = coinStats - 10
    buttonStatus6 = true
    TextStatus6.alpha = 0
    buttonChange6.alpha = 1 
    coinText.text = coinStats
    end
end
end

scene:addEventListener( "create", scene )


 
return scene