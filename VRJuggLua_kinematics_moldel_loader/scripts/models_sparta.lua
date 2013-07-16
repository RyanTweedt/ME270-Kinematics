require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())
params = defineSimulationParameters{
	maxStiffness = 300.0
}

local global_position = {0, 0, 0}
local global_orientation = AngleAxis(Degrees(0), Axis{0.0, 0.0, 0.0})
local global_voxelsize = .003
local global_scale = 1.0
local global_density = 5

1(1) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (1).osg]]),
}

1(1)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(1),
}

-----------------------------------------------------------
	
1(2) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (2).osg]]),
}

1(2)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(2),
}

-----------------------------------------------------------
	
1(3) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (3).osg]]),
}

1(3)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(3),
}

-----------------------------------------------------------
	
1(4) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (4).osg]]),
}

1(4)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(4),
}

-----------------------------------------------------------
	
1(5) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (5).osg]]),
}

1(5)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(5),
}

-----------------------------------------------------------
	
1(6) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (6).osg]]),
}

1(6)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(6),
}

-----------------------------------------------------------
	
1(7) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (7).osg]]),
}

1(7)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(7),
}

-----------------------------------------------------------
	
1(8) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (8).osg]]),
}

1(8)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(8),
}

-----------------------------------------------------------
	
1(9) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (9).osg]]),
}

1(9)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(9),
}

-----------------------------------------------------------
	
1(10) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (10).osg]]),
}

1(10)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(10),
}

-----------------------------------------------------------
	
1(11) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (11).osg]]),
}

1(11)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(11),
}

-----------------------------------------------------------
	
1(12) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (12).osg]]),
}

1(12)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(12),
}

-----------------------------------------------------------
	
1(13) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (13).osg]]),
}

1(13)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(13),
}

-----------------------------------------------------------
	
1(14) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (14).osg]]),
}

1(14)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(14),
}

-----------------------------------------------------------
	
1(15) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (15).osg]]),
}

1(15)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(15),
}

-----------------------------------------------------------
	
1(16) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (16).osg]]),
}

1(16)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(16),
}

-----------------------------------------------------------
	
1(17) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (17).osg]]),
}

1(17)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(17),
}

-----------------------------------------------------------
	
1(18) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (18).osg]]),
}

1(18)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(18),
}

-----------------------------------------------------------
	
1(19) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (19).osg]]),
}

1(19)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(19),
}

-----------------------------------------------------------
	
1(20) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (20).osg]]),
}

1(20)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(20),
}

-----------------------------------------------------------
	
1(21) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (21).osg]]),
}

1(21)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(21),
}

-----------------------------------------------------------
	
1(22) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (22).osg]]),
}

1(22)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(22),
}

-----------------------------------------------------------
	
1(23) = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\1 (23).osg]]),
}

1(23)_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	1(23),
}

-----------------------------------------------------------
	
BackLink = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\Back Link.osg]]),
}

BackLink_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	BackLink,
}

-----------------------------------------------------------
	
BottomPin = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\Bottom Pin.osg]]),
}

BottomPin_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	BottomPin,
}

-----------------------------------------------------------
	
FrontLink = Transform{
	scale = global_scale,
	orientation = global_orientation,
	Model([[H:\ME270-Kinematics\VRJuggLua_model_loader\models\OSG files\Front Link.osg]]),
}

FrontLink_sparta = addObject{
	position = global_position,
	voxelsize = global_voxelsize,
	density = global_density,
	FrontLink,
}

-----------------------------------------------------------
	

simulation:startInSchedulerThread()