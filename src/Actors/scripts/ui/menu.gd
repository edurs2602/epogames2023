extends Node2D

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/fases finais-pronto/fases finais/nivel_1.tscn")


func _on_quit_pressed():
	get_tree().quit()
