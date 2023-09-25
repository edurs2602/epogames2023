extends CanvasLayer

@onready var health_bar = $CanvasLayer/Control/healtH_bar

func _ready():
	if GlobalVariables.PLAYER_LIFE !=  health_bar.get_child_count():
		update_health(GlobalVariables.PLAYER_LIFE)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		$CanvasLayer/menu.visible

func update_health(value):
	for i in health_bar.get_child_count():
		health_bar.get_child(i).visible = value > i


func _on_player_player_take_damage(actual_life):
	print(actual_life)
	update_health(actual_life)
