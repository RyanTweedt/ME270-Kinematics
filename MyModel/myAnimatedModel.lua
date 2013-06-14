require("Actions")
require("getScriptFilename")
require ("TransparentGroup")

vrjLua.appendToModelSearchPath(getScriptFilename())

dofile(vrjLua.findInModelSearchPath([[libraries\simpleLights.lua]]))
dofile(vrjLua.findInModelSearchPath([[libraries\useful_tools.lua]]))
dofile(vrjLua.findInModelSearchPath([[libraries\loadBasicFactory.lua]]))
dofile(vrjLua.findInModelSearchPath([[libraries\Navigation.lua]]))


--initial values for positions of moving parts
local THETA = 0		--driven angle

x = 0.011
y = 0
speed = 0.05
offsetx = 32.45*ScaleFrom.inches + x
offsety = 13.22*ScaleFrom.inches + y

local xform = {}					--create an array to store the transforms for the parts that will be moving

local device = gadget.PositionInterface("VJWand")

local repos = Transform{
	position = {1.5,0,1},
	}
for i = 1,3 do				--add all the parts to the scene
	xform[i] = osg.PositionAttitudeTransform()
	xform[i]:addChild(Model("models/OSG files/Assembly ("..i..").osg")) 
	xform[i]:addChild(Sphere{ radius = .02, position = {0, 0, 0}})
	changeTransformColor(xform[i], getRandomColor())
	repos:addChild(xform[i])
end

RelativeTo.World:addChild(repos)

Actions.addFrameAction(function()		--reposition moving pieces accordingly
	local spinForwardButton = gadget.DigitalInterface("VJButton2")
	local spinBackwardButton = gadget.DigitalInterface("VJButton1")
	while true do
		if spinForwardButton.pressed then
			THETA = THETA - speed
			Actions.waitSeconds(0.01)
		end	
		if spinBackwardButton.pressed then
			THETA = THETA + speed
			Actions.waitSeconds(0.01)
		end	

		local shiftWheelx = -math.sqrt(offsetx^2 + offsety^2)*math.cos(THETA + math.atan(offsety/offsetx)) + offsetx
		local shiftWheely = -math.sqrt(offsetx^2 + offsety^2)*math.sin(THETA + math.atan(offsety/offsetx)) + offsety
		
		xform[3]:setAttitude(osg.Quat(THETA,osg.Vec3d(0,0,1)))
		xform[3]:setPosition(osg.Vec3d(shiftWheelx, shiftWheely,0))
		
		Actions.waitForRedraw()
	end
end)