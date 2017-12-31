local composer = require( "composer" )
 
local scene = composer.newScene()

function scene:create( event )
 
    local sceneGroup = self.view
   appodeal = require( "plugin.appodeal" )
   function adListener( event )
    if ( event.phase == "init" ) then  -- Successful initialization
        print( event.isError )
    end
end
appodeal.init( adListener, { appKey="febb30867f96ee0c6eb1db1291079f77adad7a86bcdda6f1" } )
appodeal.show("interstitial")
bg = display.newRect(_X,_Y,_W,_H)
bg:setFillColor(0.0,0.29,0.33)
buttonBg = display.newRoundedRect(_X,_Y,_W/1.8,_H/7,_W/40)
buttonBg:setFillColor(0.84,0.43,0)
buttonBg.strokeWidth = 2
buttonBg:setStrokeColor(0,0,0)
opt = {
    text = "PLAY",
    x = _X,
    y = _Y,
    fontSize = _W/6,
    align = "right"
}
playText = display.newText(opt)
opt2 = {
    text = "Car GO!",
    x = _X,
    y = _H/6,
    fontSize = _W/5,
    align = "right"
}
appodeal.load("banner")
nameText = display.newText(opt2)
function nextScene()
    composer.gotoScene("game")
end
buttonBg:addEventListener("tap",nextScene)
end

scene:addEventListener( "create", scene )


 
return scene