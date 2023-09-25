extends HBoxContainer

func _ready():
	if GlobalVariables.PLAYER_LIFE !=  get_child_count():
		update_health(GlobalVariables.PLAYER_LIFE)

func update_health(value):
	for i in get_child_count():
		get_child(i).visible = value > i


func _on_player_player_take_damage(actual_life):
	print(actual_life)
	update_health(actual_life)
