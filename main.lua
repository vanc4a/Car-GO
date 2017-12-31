composer = require( "composer" )
_W = display.contentWidth
_H = display.contentHeight
_Y = display.contentCenterY
_X = display.contentCenterX
display.setStatusBar(display.HiddenStatusBar)
bg = display.newRect(_X,_Y,_W,_H)
bg:setFillColor(math.random(),math.random(),math.random())
local options = {
    text = "LIV Studio",
    x = _X,
    y = _Y,
    fontSize = _H/12,
}
logoText = display.newText(options)
function delay()
	composer.gotoScene("menu")
end
timer.performWithDelay(3000,delay,1)