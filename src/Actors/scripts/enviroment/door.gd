extends StaticBody2D

@export var is_open = false
@export var door_group = "none"
@export var number_of_levers = 0
var atived_levers = 0

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play("door_closed")

func door():
	pass
	
func open_door():
	is_open = true
	animated_sprite.play("door_opened")
	self.set_collision_layer_value(3,false)
	
func close_door():
	is_open = false
	self.set_collision_layer_value(3,true)


func _on_torch_torch_lighted(torch_group):
	
	print(torch_group)
	
	if torch_group == door_group:
		atived_levers += 1
	
	if atived_levers == number_of_levers:
		open_door()



func _on_torch_2_torch_lighted(torch_group):
	if torch_group == door_group:
		atived_levers += 1
	
	if atived_levers == number_of_levers:
		open_door()
