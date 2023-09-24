extends Area2D

@export var is_lighted = false
@export var door_group = "none"

signal torch_lighted

func _ready():
	$AnimatedSprite2D.play("turned_off")

func torch():
	pass

func _on_area_entered(area):
	print(area)
	if !is_lighted:
		is_lighted = true
		$AnimatedSprite2D.play("turned_on")
		torch_lighted.emit(door_group)
