require("Actions")
require("getScriptFilename")
require ("TransparentGroup")

vrjLua.appendToModelSearchPath(getScriptFilename())

--dofile(vrjLua.findInModelSearchPath([[DrawableShapesMod.lua]]))
dofile(vrjLua.findInModelSearchPath([[simpleLights.lua]]))

--[[
require neccessary files
load in model parts

attach vectors to parts
add frameactions to animate the parts
]]

--initial values for positions of moving parts
theta1 = 5.977306			--constant angle of the closed vector system
THETA2 = 6.085789747		--driven angle for the closed vector system
theta3 = -1.5708
theta4 = 3.092452
dT2 = 0 --The angle THETA2 has changed

r1 = 19.92486				--the length of vector r1, the distance from the lever pivot to the pusher pivot
r2 = 3.824265				--the length of vector r2, the distance to the top bolt from the lever pivot
r3 = 4.5					--the length of the link pices
r4 = 15.26843				--the length the pusher

offsetx = 0
offsety = 0

p1 = {x = 20.75 + offsetx, y = 19.25 + offsety, z = 0}				--location of the lever pivot, 	static
p2 = {x = 17 + offsetx, y = 18.5 + offsety, z = 0}					--location of the top bolt, 	dynamic
p3 = {x = 17 + offsetx, y = 14 + offsety, z = 0}					--location of the bottom bolt,	dynamic
p4 = {x = 1.75 + offsetx, y = 13.25 + offsety, z = 0}				--location of the pusher pivot,	static

scale = ScaleFrom.inches


--dumy variables used to compute angles and positions
A = 465.6871601
B = -160.3185305
C = 473
t = 40.69124199

part = {}					--create an arrays to store all the parts
xform = {}					--create an array to store the transforms for the parts that will be moving

for i =1,31 do				--add all the parts to the scene filtering out all of the parts that will be moving and adding them to transforms
	if i == 4 or 5 or 8 or 9 or 10 or 11 then
		xform[i] = osg.PositionAttitudeTransform()
		RelativeTo.World:addChild(xform[i])
		xform[i]:addChild(Model("OSG files/Assembly ("..i..").STL.osg")) 
		xform[i]:addChild(Sphere{ radius = .02, position = {0, 0, 0}})
		
	else
		part[i] = Model("OSG files/Assembly ("..i..").STL.osg")
		RelativeTo.World:addChild(part[i])
	end
end

--[[
xform[4]	top bolt (p2)
xform[5]	bottom bolt (p3)
xform[8]	link
xform[9]	link
xform[10]	lever
xform[11]	pusher
]]

Actions.addFrameAction(function()		--reposition moving pieces accordingly
	while true do
		A = 2*r1*r4*math.cos(theta1) - 2*r2*r4*math.cos(THETA2)
		B = 2*r1*r4*math.sin(theta1) - 2*r2*r4*math.sin(THETA2)	
		C = r1^2 + r2^2 + r4^2 - r3^2 - 2*r1*r2*(math.cos(theta1)*math.cos(THETA2) + math.sin(theta1)*math.sin(THETA2))
		t = (-B + math.sqrt(B^2 - C^2 + A^2))/(C - A)
		theta4 = 2*math.atan(t)
		theta3 = math.atan((r1*math.sin(theta1) + r4*math.sin(theta4) - r2*math.sin(THETA2))/(r1*math.cos(theta1) + r4*math.cos(theta4) - r2*math.cos(THETA2)))
		shift2x = (p1.x - r2*math.cos(THETA2) - p2.x)*scale
		shift2y = (p1.y + r2*math.sin(THETA2) - p2.y)*scale
		shift3x = (p2.x - r3*math.cos(theta3) - p3.x)*scale
		shift3y = (p2.y + r3*math.sin(theta3) - p3.y)*scale
		dT2 = -(THETA2 - 6.085789747)

		Actions.waitForRedraw()
	end
end)



--------------------------------------------------------------------------------------------------------------------------------------------

Actions.addFrameAction(function()
		while true do
			
			xform[4]:setPosition(osg.Vec3d(shift2x, shift2y, 0))
			
			xform[5]:setPosition(osg.Vec3d(shift3x, shift3y, 0))
			
			xform[9]:setAttitude(osg.Quat(-(theta3 + 1.5708),osg.Vec3d(0,0,1)))
			
			xform[8]:setPosition(osg.Vec3d(((r2 - r2*math.cos(THETA2)))*scale,(r2*math.sin(THETA2)-r2*math.sin(6.085789747))*scale,0))
			xform[9]:setPosition(osg.Vec3d(((r2 - r2*math.cos(THETA2)) - r2*math.cos(math.atan(shift2y/shift2x) + (theta3 + 1.5708)) - shift2x)*scale,(r2*math.sin(THETA2)-r2*math.sin(6.085789747) + shift2y - r2*math.sin(math.atan(shift2y/shift2x) + (theta3 + 1.5708)))*scale,0))
			
			xform[10]:setAttitude(osg.Quat(dT2,osg.Vec3d(0,0,1)))
			xform[10]:setPosition(osg.Vec3d((p1.x - (math.sqrt(p1.x^2 + p1.y^2)*math.cos(dT2 + math.atan(p1.y/p1.x))))*scale, -((math.sqrt(p1.x^2 + p1.y^2)*math.sin(dT2 + math.atan(p1.y/p1.x))) - p1.y)*scale, 0))

			Actions.waitForRedraw()
		end
	end)
	
--------------------------------------------------------------------------------------------------------------------------------------------	
	
--18 = the plunger

--todo: add an action to move bolts to the positins p2 and p3, then look into moving the lever, links, and pusher wilhe rotating them
