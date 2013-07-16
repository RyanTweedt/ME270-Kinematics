function rotateAboutPoint(a)
--[[ inputs
	model: the model to rotate
	axis: the vector to rotate about
	point: the position of the point to rotate about ( form: point = {x, y, z} )
	angle: the angle to rotate in radians
	scale: use to adjust units if needed
	offset: the offset from the axis that the conversion proccess adds
]]
	
	local pt = {}
	--Add default offsets if none are specified
	if not a.offset then
		pt = {x = a.point.x + 0.11, y = a.point.y + 0, z = a.point.z + 0}
	else
		pt = {x = a.point.x + a.offset.x, y = a.point.y + a.offset.y, z = a.point.z + a.offset.z}
	end
	
	--Determine distance from origin to point
	local radius = math.sqrt(pt.x^2 + pt.y^2 + pt.z^2)
	
	--Find initial angle
	local intAngle = math.atan(pt.y/pt.x)
	
	--Find the neccessary shift in x
	local shiftX = (pt.x - radius*math.cos(a.angle + intAngle))*a.scale

	--Find the neccessary shift in y
	local shiftY = (pt.y - radius*math.sin(a.angle + intAngle))*a.scale

	--Nothing working for z yet, function will only work when working in the xy plane
	local shiftZ = 0
	--a.model:addChild(Sphere{ radius = .01, position = {pt.x*a.scale, pt.y*a.scale, pt.z}, color = getRandomColor()})
	a.model:setAttitude(osg.Quat(a.angle,a.axis))
	a.model:setPosition(osg.Vec3d(shiftX, shiftY, shiftZ))
	return a.model
end

function getOffsets(a)
--[[ Lengend
	axis = the vector to rotate about
	point = the position of the point to rotate about ( form: point = {x, y, z} )
	angle = the angle to rotate in radians
	scale: use to adjust units if needed
	offset: the offset from the axis that the conversion proccess adds
]]

	local pt = {}
	--Add default offsets if none are specified
	if not a.offset then
		pt = {x = a.point.x + 0.11, y = a.point.y + 0, z = a.point.z + 0}
	else
		pt = {x = a.point.x + a.offset.x, y = a.point.y + a.offset.y, z = a.point.z + a.offset.z}
	end
	
	--Determine distance from origin to point
	local radius = math.sqrt(pt.x^2 + pt.y^2 + pt.z^2)
	
	--Find initial angle
	local intAngle = math.atan(pt.y/pt.x)
	
	--Find the neccessary shift in x
	local shiftX = (pt.x - radius*math.cos(a.angle + intAngle))*a.scale

	--Find the neccessary shift in y
	local shiftY = (pt.y - radius*math.sin(a.angle + intAngle))*a.scale

	--Nothing working for z yet, function will only work when working in the xy plane
	local shiftZ = 0
	return {x = shiftX, y = shiftY, z = shiftZ}
end