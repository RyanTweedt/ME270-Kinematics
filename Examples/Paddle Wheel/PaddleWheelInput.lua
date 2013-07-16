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

local pos = {x = 32.45, y = 13.22}
local THETA = 0

function input(direction)

---------------------------------------------------------------------[ Limits ]---------------------------------------------------------------------
-- This section defines limits of operation for the driven variable
-- Set drivenVariable to equal the variable you want to controlled (such as the angle of a lever or wheel)

-- Initial value:
local initVal = 0

-- Upper limit:
local upperLimit = 100*math.pi

-- Lower limit:
local lowerLimit = -100*math.pi

-- Speed of animation (0 stopped to 10 really fast)
local speed = 10

-- Driven variable (Enter the variable both here as well as below)
drivenVariable = THETA
	
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
THETA = drivenVariable

-------------------------------------------------------------------[ Equations ]--------------------------------------------------------------------
-- Add comments above or after your equations to help you remember what they are doing
-- To use a trig function enter math.sin() or math.atan()
-- To use a square root enter math.sqrt()
-- To use pi enter math.pi
	
-- No equations needed

------------------------------------------------------------------[ Definitions ]-------------------------------------------------------------------
-- Create as many lines as you need by copy and pasting
-- Filename should be the exact name of the file and remember, NO PARENTHESES (you also don't need to include the extension)
-- RotationPoint should be any point you want your part to pivot about in the XY plane
-- Angle should be in terms of a driven variable
-- X, Y, and Z are the axis of translation

	Rotations = {
		{Filename = "Acrylic Plate 1", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Acrylic Plate 2", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Axel", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Collar 1", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Collar 2", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Collar 3", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Collar 4", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Collar 5", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Collar 6", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Collar 7", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Key 1", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Key 2", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Key 3", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Paddle 1", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Paddle 2", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Paddle 3", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Paddle 4", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Paddle 5", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Paddle 6", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Paddle 7", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Paddle 8", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
		{Filename = "Axel Sprocket", RotationPoint = {x = pos.x, y = pos.y, z = 0}, Angle = THETA},
	}

	Translations = {
		-- No parts need to translate for this model
	}
	
	return Rotations, Translations
end

------------------------------------------------------------------[ Finishing Up ]------------------------------------------------------------------
-- Now all that is left is to save this file. Just hit the save button as it is the easiest way without accidentally changeing the file type.
-- Congradulations, you're finished! :D