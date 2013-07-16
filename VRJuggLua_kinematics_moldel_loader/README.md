VRJuggLua_kinematics_moldel_loader
==================================

A simple script to load in OSG and IVE models into a VRJuggLua environment and apply kinematics as specifide by an input script if provided.

Use: Simply drop any group of OSG and or IVE models along with an input script onto one of the launchers at the top level. You can also use a
a text doc containing the file locations of the models in each line instead of the models themselves. For the input script, see InputTemplate.lua

Note: If rotating parts are not rotating about the proper point, adjust the variable offsetx in the command window. The default value is 0.11 but 
this number may be different for every model. 