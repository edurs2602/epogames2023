extends Area2D

@export var next_scene = preload("res://scenes/levels/level_2.tscn")

func _on_body_entered(body):
	body.set_process(false)
	body.receive_knockback(Vector2(100,100), false,2)
	$Timer.start()

func _on_timer_timeout():
	get_tree().change_scene_to_file(next_scene)
