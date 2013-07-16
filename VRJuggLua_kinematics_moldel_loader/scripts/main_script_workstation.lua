--======================================================================================================================================================================--
--===========================================================================[ 270 Kinematics ]=========================================================================--
--======================================================================================================================================================================--
--[[
Author:			Ryan Tweedt
Date:				7/1/13
Version:			1.4
Description:	This is an edited version of Leif Berg's VRJuggLua_model_loader that adds in an option for kinematics.
]]
-------------------------------------------------------------------[ Initialization ]--------------------------------------------------------------------

require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())

--set buttons required for SimSparta
nextBtn = gadget.DigitalInterface("VJButton0")
dragBtn = gadget.DigitalInterface("VJButton2")
resetBtn = gadget.DigitalInterface("VJButton0")
-- prevBtn = gadget.DigitalInterface("VJButton1")
--for scaling action frame at bottom - no more buttons!
-- increaseBtn = 
-- decreaseBtn = 
driveForwardBtn = gadget.DigitalInterface("VJButton1")
driveBackwardBtn = gadget.DigitalInterface("VJButton2")

--load useful_tools for getRandomColor(), changeTransformColor(), and scaleTransform()
dofile([[libraries\useful_tools.lua]])
--load SimSparta for createManipulatableObject() and SimSparta() - frame action call
dofile([[libraries\SimSparta.lua]])
--add factory model
dofile([[libraries\loadBasicFactory.lua]])
--add lighting to scene
dofile([[libraries\simpleLights.lua]])
--add in rotate function
dofile([[libraries\rotateFunction.lua]])

print("offsetx = 0.11, if parts are not revolving around the proper point then adjust this variable as needed")
offsetx = 0.11
offsety = 0 
local models = {}
local counter = 0
--creat a table to contain the strings for the file paths to pass to the Drive function for kinematics
names = {}
--Transformation table for kinematics
drive_xform = {}
--set different postion for working on workstation (vs. METaL)
local repos = Transform{
	position = {1, 1.5, .25},
	}
	
-------------------------------------------------------------------[ Functions ]--------------------------------------------------------------------

local loadModelPathsFromFile = function(filename)
	local file = assert(io.open(filename, "r"))
	for v in file:lines() do
		counter = counter + 1
		names[counter] = v
		model = Transform{Model(v)}
		model_xform = Transform{model}
		table.insert(models, model)
		changeTransformColor(model_xform, getRandomColor())
		drive_xform[v] = osg.PositionAttitudeTransform()
		drive_xform[v]:addChild(createManipulatableObject(model_xform))
		repos:addChild(drive_xform[v])
	end
end

local loadOSGsAndIves = function()
	for i, v in pairs(arg) do
		if string.find(v, ".osg") or string.find(v, ".ive") then
			names[i] = v
			model = Transform{Model(v)}
			model_xform = Transform{model}
			table.insert(models, model)
			changeTransformColor(model_xform, getRandomColor())
			drive_xform[v] = osg.PositionAttitudeTransform()
			drive_xform[v]:addChild(createManipulatableObject(model_xform))
			repos:addChild(drive_xform[v])
		elseif  string.find(v, ".txt") then
			loadModelPathsFromFile(v)
		end
	end
end

function Drive(direction, parts, filenames)

	local Rotations
	local Translations 
	Rotations, Translations = input(direction)
	
--Rotations
	for i = 1, table.getn(Rotations) do 
		for num,path in pairs(filenames) do
			if string.find(path, Rotations[i].Filename) then
					parts[path] = rotateAboutPoint{
						model = parts[path],
						axis = osg.Vec3d(0,0,1),
						angle = Rotations[i].Angle,
						point = Rotations[i].RotationPoint,
						scale = scale,
						offset = {x = offsetx, y = offsety, z = 0},
					}
			end
		end
	end

--Translations
	for i = 1, table.getn(Translations) do 
		for num,path in pairs(filenames) do
			if string.find(path, Translations[i].Filename) then
				parts[path]:setPosition(osg.Vec3d(Translations[i].X, Translations[i].Y, Translations[i].Z))
			end
		end
	end
		
	Actions.waitForRedraw()
end

--load in the files
loadOSGsAndIves()
RelativeTo.World:addChild(repos)

-------------------------------------------------------------------[ Frame Actions ]--------------------------------------------------------------------

--adding SimSparted frame action
SimSparta(dragBtn, nextBtn, prevBtn, resetBtn)

--add frame action for kinematics
Actions.addFrameAction(
	function()
		while true do
			if driveForwardBtn.pressed then
				Drive(1,drive_xform,names)
			elseif driveBackwardBtn.pressed then
				Drive(-1,drive_xform,names)
			else
				Drive(0,drive_xform,names)
			end
			Actions.waitForRedraw()
		end
	end
)

-- add frame action for scaling objects - featured commented out as workstation has not more buttons!
-- Actions.addFrameAction(
	-- function()
		-- while true do
			-- if increaseBtn.justPressed then
				-- for _, v in ipairs(models) do
					-- scaleTransform(v, v:getScale():x() * 1.05)
				-- end
			-- end
			-- if decreaseBtn.justPressed then
				-- for _, v in ipairs(models) do
					-- scaleTransform(v, v:getScale():x() * 0.95)
				-- end
			-- end
			-- Actions.waitForRedraw()
		-- end
	-- end
-- )