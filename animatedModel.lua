require("Actions")
require("getScriptFilename")
require ("TransparentGroup")

vrjLua.appendToModelSearchPath(getScriptFilename())

dofile(vrjLua.findInModelSearchPath([[libraries\simpleLights.lua]]))
dofile(vrjLua.findInModelSearchPath([[libraries\useful_tools.lua]]))
dofile(vrjLua.findInModelSearchPath([[libraries\loadBasicFactory.lua]]))
dofile(vrjLua.findInModelSearchPath([[libraries\Navigation.lua]]))


--initial values for positions of moving parts
local theta1 = 5.977306			--constant angle of the closed vector system
local THETA2 = 6.085789747		--driven angle for the closed vector system
local theta3 = -1.5708
local theta4 = 3.092452

local r1 = 19.92486				--the length of vector r1, the distance from the lever pivot to the pusher pivot
local r2 = 3.824265				--the length of vector r2, the distance to the top pin from the lever pivot
local r3 = 4.5					--the length of the link pices
local r4 = 15.26843				--the length the pusher

offsetx = 0.11
offsety = 0

local p1 = {x = 20.75 + offsetx, y = 19.25 + offsety, z = 0}				--location of the lever pivot, 	static
local p2 = {x = 17 + offsetx, y = 18.5 + offsety, z = 0}					--location of the top pin, 	dynamic
local p3 = {x = 17 + offsetx, y = 14 + offsety, z = 0}					--location of the bottom pin,	dynamic
local p4 = {x = 1.75 + offsetx, y = 13.25 + offsety, z = 0}				--location of the pusher pivot,	static

local scale = ScaleFrom.inches

--dumy variables used to compute angles and positions
local A = 465.6871601
local B = -160.3185305
local C = 473
local t = 40.69124199

local part = {}					--create an arrays to store all the parts
local xform = {}					--create an array to store the transforms for the parts that will be moving

--[[Legend:
		xform[4]	top pin
		xform[5]	bottom pin
		xform[8]	link
		xform[9]	link
		xform[10]	lever
		xform[11]	pusher
]]

local device = gadget.PositionInterface("VJWand")

local repos = Transform{
	position = {1.5,0.5,0},
	}
for i =1,31 do				--add all the parts to the scene
	xform[i] = osg.PositionAttitudeTransform()
	xform[i]:addChild(Model("models/OSG files/Assembly ("..i..").STL.osg")) 
	xform[i]:addChild(Sphere{ radius = .02, position = {0, 0, 0}})
	changeTransformColor(xform[i], getRandomColor())
	repos:addChild(xform[i])
end

RelativeTo.World:addChild(repos)

Actions.addFrameAction(function()		--reposition moving pieces accordingly
	local upButton = gadget.DigitalInterface("VJButton1")
	local downButton = gadget.DigitalInterface("VJButton2")
	while true do
	
		A = 2*r1*r4*math.cos(theta1) - 2*r2*r4*math.cos(THETA2)
		B = 2*r1*r4*math.sin(theta1) - 2*r2*r4*math.sin(THETA2)	
		C = r1^2 + r2^2 + r4^2 - r3^2 - 2*r1*r2*(math.cos(theta1)*math.cos(THETA2) + math.sin(theta1)*math.sin(THETA2))
		t = (-B + math.sqrt(B^2 - C^2 + A^2))/(C - A)
		
		theta4 = 2*math.atan(t)
		theta3 = math.atan((r1*math.sin(theta1) + r4*math.sin(theta4) - r2*math.sin(THETA2))/(r1*math.cos(theta1) + r4*math.cos(theta4) - r2*math.cos(THETA2)))
		
		local shiftTopPinx = (p1.x - r2*math.cos(THETA2) - p2.x)*scale
		local shiftTopPiny = (p1.y + r2*math.sin(THETA2) - p2.y)*scale
		
		local shiftBottomPinx = (r4*math.cos(3.14159265358979 - theta4) - r4)*scale
		local shiftBottomPiny = (r4*math.sin(3.14159265358979 - theta4) - 0.75)*scale
		
		local leverAngle = -(THETA2 - 6.085789747)
		local shiftLeverx = (p1.x - (math.sqrt(p1.x^2 + p1.y^2)*math.cos(leverAngle + math.atan(p1.y/p1.x))))*scale
		local shiftLevery = -((math.sqrt(p1.x^2 + p1.y^2)*math.sin(leverAngle + math.atan(p1.y/p1.x))) - p1.y)*scale
		
		--Piecewise solution for the discontinuity in theta3
		local linkAngle
		if theta3 > 0 then
			linkAngle = -(theta3 + 1.5708) + 3.14159
		else
			linkAngle = -(theta3 + 1.5708)
		end
		
		local shiftLinkx = (math.sqrt((p2.x*scale)^2+(p2.y*scale)^2))*math.cos(math.atan((p2.y*scale)/(p2.x*scale))) - (math.sqrt((p2.x*scale)^2+(p2.y*scale)^2))*math.cos((linkAngle+math.atan((p2.y*scale)/(p2.x*scale))))
		local shiftLinky = (math.sqrt((p2.x*scale)^2+(p2.y*scale)^2))*math.sin(math.atan((p2.y*scale)/(p2.x*scale))) - (math.sqrt((p2.x*scale)^2+(p2.y*scale)^2))*math.sin((linkAngle+math.atan((p2.y*scale)/(p2.x*scale))))
		
		local pusherAngle = 3.14159265358979 - (theta4 + 0.04914073)
		local shiftPusherx = (p4.x - (math.sqrt(p4.x^2 + p4.y^2))*math.cos(pusherAngle + (math.atan(p4.y/p4.x))))*scale
		local shiftPushery = (-(math.sqrt(p4.x^2 + p4.y^2))*math.sin(pusherAngle + (math.atan(p4.y/p4.x))) + p4.y)*scale
		
--------------------------------------------------------------------------------------------------------------------------------------------------
		--animate
		
		if upButton.pressed then
			if THETA2 < 7.4 then
				THETA2 = THETA2 + 0.025
				Actions.waitSeconds(0.01)
			else
				Actions.waitSeconds(0.01)
			end
		end
		if downButton.pressed then
			if THETA2 > 5.87 then
				THETA2 = THETA2 - 0.025
				Actions.waitSeconds(0.01)
			else
				Actions.waitSeconds(0.01)
			end
		end
		
--------------------------------------------------------------------------------------------------------------------------------------------------
		xform[4]:setPosition(osg.Vec3d(shiftTopPinx, shiftTopPiny, 0))  --top pin good
		xform[5]:setPosition(osg.Vec3d(shiftBottomPinx, shiftBottomPiny, 0))  --bot pin good
		--Links
		xform[8]:setAttitude(osg.Quat(linkAngle,osg.Vec3d(0,0,1)))
		xform[9]:setAttitude(osg.Quat(linkAngle,osg.Vec3d(0,0,1)))
		xform[8]:setPosition(osg.Vec3d(shiftTopPinx + shiftLinkx, shiftTopPiny + shiftLinky, 0))
		xform[9]:setPosition(osg.Vec3d(shiftTopPinx + shiftLinkx, shiftTopPiny + shiftLinky, 0))
		--Lever
		xform[10]:setAttitude(osg.Quat(leverAngle,osg.Vec3d(0,0,1)))  --lever good
		xform[10]:setPosition(osg.Vec3d(shiftLeverx, shiftLevery, 0))
		--Pusher
		xform[11]:setAttitude(osg.Quat(pusherAngle,osg.Vec3d(0,0,1)))  --pusher bad
		xform[11]:setPosition(osg.Vec3d(shiftPusherx, shiftPushery,0))
		
		Actions.waitForRedraw()
	end
end)

--18 = the plunger

--todo: add an action to move pins to the positins p2 and p3, then look into moving the lever, links, and pusher wilhe rotating them
