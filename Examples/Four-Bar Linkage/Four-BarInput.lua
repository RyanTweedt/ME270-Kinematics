--================================================================================================================================================--
--==============================================================[ ME270 Kinematics ]==============================================================--
--================================================================================================================================================--
--[[ 

This is the template for adding kinematics to your model. The following is a LUA function that will be called by the main program. To correctly fill 
out the template just follow the instructions for each section and look at the examples provided.

A couple of notes: ]]

-- Means this line is a comment, nothing on this line will be read by the program
--[[ Starts a long comment; it can be ended like this ]]

-------------------------------------------------------------------[ Variables ]--------------------------------------------------------------------
-- This section is where you define all of your variables
-- In order to prevent accidental use of a variable name that is already in use by the program add 'local' in front of the variable name
-- See the example for how to create variables and tables

scale = ScaleFrom.inches	--delete this line if your model's dimensions are in meters, else set scale to the apropriate factor to convert to meters

local THETA2 = 6.085789747
local p1 = {x = 20.75, y = 19.25, z = 0}		--location of the lever pivot, 	static
local p2 = {x = 17 , y = 18.5, z = 0}			--location of the top pin, 	dynamic
local p3 = {x = 17, y = 14, z = 0}			--location of the bottom pin,	dynamic
local p4 = {x = 1.75, y = 13.25, z = 0}			--location of the pusher pivot,	static
local theta1 = 5.977306
local r1 = 19.92486					--the length of vector r1, the distance from the lever pivot to the pusher pivot
local r2 = 3.824265					--the length of vector r2, the distance to the top pin from the lever pivot
local r3 = 4.5						--the length of the link pieces
local r4 = 15.26843					--the length the pusher
local A
local B
local C
local t
local theta3
local theta4
local leverAngle
local pusherAngle
local linkAngle
local shiftLinkx
local shiftLinky
local topPinLocation
local shiftTopPinx 
local shiftTopPiny
local shiftPlungery
local plungerAngle

function input(direction)

---------------------------------------------------------------------[ Limits ]---------------------------------------------------------------------
-- This section defines limits of operation for the driven variable
-- Set drivenVariable to equal the variable you want to controlled (such as the angle of a lever or wheel)

-- Initial value:
local initVal = 6.085789747

-- Upper limit:
local upperLimit = 7.38

-- Lower limit:
local lowerLimit = 5.8768

-- Speed of animation (0 stopped to 10 really fast)
local speed = 4

-- Driven variable (Enter the variable both here as well as below)
drivenVariable = THETA2
	
-- Edit this only if you know what you are doing:
------------------------------------------------------------------	
if resetVar ~= nil then						--
	drivenVariable = initVal				--
	resetVar = nil						--
end								--
if direction > 0 then						--
	if drivenVariable <= upperLimit - speed/100 then	--
		drivenVariable = drivenVariable + speed/100	--
	elseif drivenVariable >= upperLimit - speed/100 then	--
		drivenVariable = upperLimit			--
	end							--
end								--
if direction < 0 then						--
	if drivenVariable >= lowerLimit + speed/100 then	--
		drivenVariable = drivenVariable - speed/100	--
	elseif drivenVariable <= lowerLimit + speed/100 then	--
		drivenVariable = lowerLimit			--
	end							--
end								--
------------------------------------------------------------------

-- Driven variable (Enter the variable here too)
THETA2 = drivenVariable
	
-------------------------------------------------------------------[ Equations ]--------------------------------------------------------------------
-- Add comments above or after your equations to help you remember what they are doing
-- to use a trig function enter math.sin() or math.atan()
-- to use a square root enter math.sqrt()
-- to use pi enter math.pi

	--Vector equations
	A = 2*r1*r4*math.cos(theta1) - 2*r2*r4*math.cos(THETA2)
	B = 2*r1*r4*math.sin(theta1) - 2*r2*r4*math.sin(THETA2)	
	C = r1^2 + r2^2 + r4^2 - r3^2 - 2*r1*r2*(math.cos(theta1)*math.cos(THETA2) + math.sin(theta1)*math.sin(THETA2))
	t = (-B + math.sqrt(B^2 - C^2 + A^2))/(C - A)
	theta4 = 2*math.atan(t)
	theta3 = math.atan((r1*math.sin(theta1) + r4*math.sin(theta4) - r2*math.sin(THETA2))/(r1*math.cos(theta1) + r4*math.cos(theta4) - r2*math.cos(THETA2)))
	
	--Lever
	leverAngle = 6.085789747 - THETA2
	
	--Pusher
	pusherAngle = math.pi - (theta4 + 0.04914073)
	
	--Links
	if theta3 > 0 then
		linkAngle = math.pi/2 - theta3
	else
		linkAngle = -theta3 - math.pi/2
	end

	shiftLinkx = (math.sqrt(((p2.x + 0.11)*scale)^2+(p2.y*scale)^2))*math.cos(math.atan((p2.y*scale)/((p2.x + 0.11)*scale))) - (math.sqrt(((p2.x + 0.11)*scale)^2+(p2.y*scale)^2))*math.cos((linkAngle+math.atan((p2.y*scale)/((p2.x + 0.11)*scale))))
	shiftLinky = (math.sqrt(((p2.x + 0.11)*scale)^2+(p2.y*scale)^2))*math.sin(math.atan((p2.y*scale)/((p2.x + 0.11)*scale))) - (math.sqrt(((p2.x + 0.11)*scale)^2+(p2.y*scale)^2))*math.sin((linkAngle+math.atan((p2.y*scale)/((p2.x + 0.11)*scale))))

	topPinLocation = getOffsets{
		axis = osg.Vec3d(0,0,1),
		angle = leverAngle,
		point = {x = p1.x, y = p1.y, z = 0},
		scale = scale,
		}
	linkRotatePoint = {x = topPinLocation.x + p2.x, y = topPinLocation.y + p2.y, z = topPinLocation.z + p2.z}
	
	--Plunger
	plungerAngle = (math.pi - theta4) - 0.04914065358
	if leverAngle < 0 then
		shiftPlungery = (1.75 - 4.1152526*math.tan(math.atan(1.75/4.1152526) - plungerAngle))*scale
	else
		shiftPlungery = (1.75 - 7.3652526*math.tan(math.atan(1.75/7.3652526) - plungerAngle))*scale
	end
	
	--Top Pin
	shiftTopPinx = (p1.x - r2*math.cos(THETA2) - p2.x)*scale
	shiftTopPiny = (p1.y + r2*math.sin(THETA2) - p2.y)*scale

------------------------------------------------------------------[ Definitions ]-------------------------------------------------------------------
-- Create as many lines as you need by copy and pasting
-- Filename should be the exact name of the file and remember, NO PARENTHESES (you also don't need to include the extension)
-- RotationPoint should be any point you want your part to pivot about in the XY plane
-- Angle should be in terms of a driven variable
-- X, Y, and Z are the axis of translation

	Rotations = {
		{Filename = "Bottom Pin", RotationPoint = {x = 1.75, y = 13.25, z = 0}, Angle = pusherAngle},
		{Filename = "Top Pin", RotationPoint = {x = 20.75, y = 19.25, z = 0}, Angle = leverAngle},
		{Filename = "Back Link", RotationPoint = linkRotatePoint, Angle = linkAngle},
		{Filename = "Front Link", RotationPoint = linkRotatePoint, Angle = linkAngle},
		{Filename = "Lever", RotationPoint = {x = 20.75, y = 19.25, z = 0}, Angle = leverAngle},
		{Filename = "Pusher", RotationPoint = {x = 1.75, y = 13.25, z = 0}, Angle = pusherAngle},
	}

	Translations = {
		{Filename = "Plunger", X = 0, Y = (shiftPlungery + 0.75*scale), Z = 0},
		{Filename = "Back Link", X = (shiftTopPinx + shiftLinkx), Y = (shiftTopPiny + shiftLinky), Z = 0},
		{Filename = "Front Link", X = (shiftTopPinx + shiftLinkx), Y = (shiftTopPiny + shiftLinky), Z = 0},
	}
	
	return Rotations, Translations
end