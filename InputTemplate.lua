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

-- Example variables
local w = 0
local MoveX 
local y = {1, 2, 4}
local z = { var1 = 5, var2 = 10}
local theta = math.pi

function input(direction)

---------------------------------------------------------------------[ Limits ]---------------------------------------------------------------------
-- This section defines limits of operation for the driven variable
-- Set drivenVariable to equal the variable you want to controlled (such as the angle of a lever or wheel)

-- Initial value:
local initVal = 0

-- Upper limit:
local upperLimit = 2*math.pi

-- Lower limit:
local lowerLimit = 0

-- Speed of animation (0 stopped to 10 really fast)
local speed = 5

-- Driven variable (Enter the variable both here as well as below)
drivenVariable = w
	
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
w = drivenVariable

-------------------------------------------------------------------[ Equations ]--------------------------------------------------------------------
-- Add comments above or after your equations to help you remember what they are doing
-- To use a trig function enter math.sin() or math.atan()
-- To use a square root enter math.sqrt()
-- To use pi enter math.pi

-- Example equations
MoveX = math.cos(w) + math.sqrt(z.var1^2 + z.var2^2)
	
------------------------------------------------------------------[ Definitions ]-------------------------------------------------------------------
-- Create as many lines as you need by copy and pasting
-- Filename should be the exact name of the file and remember, NO PARENTHESES (you also don't need to include the extension)
-- RotationPoint should be any point you want your part to pivot about in the XY plane
-- Angle should be in terms of a driven variable
-- X, Y, and Z are the axis of translation

	Rotations = {
		{Filename = "Bottom Pin", RotationPoint = {x = 1.75, y = 13.25, z = 0}, Angle = w},
		{Filename = "Top Pin", RotationPoint = {x = 20.75, y = 19.25, z = 0}, Angle = w},
	}

	Translations = {
		{Filename = "Plunger", X = MoveX, Y = 0, Z = 0},
	}
	
	return Rotations, Translations
end

------------------------------------------------------------------[ Finishing Up ]------------------------------------------------------------------
-- Now all that is left is to save this file. Just hit the save button as it is the easiest way without accidentally changeing the file type.
-- Congradulations, you're finished! :D