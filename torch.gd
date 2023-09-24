extends Area2D

@export var is_lighted = false
@export var door_group = "none"

signal torch_lighted

func torch():
	pass

func _on_area_entered(area):
	print(area)
	if !is_lighted:
		is_lighted = true
		torch_lighted.emit(door_group)
