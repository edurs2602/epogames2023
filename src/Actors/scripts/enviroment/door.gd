extends StaticBody2D

@export var is_open = false

func door():
	pass
	
func open_door():
	is_open = true
	self.set_collision_layer_value(3,false)
	
func close_door():
	is_open = false
	self.set_collision_layer_value(3,true)
