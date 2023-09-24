extends Control

var power_1 
var power_2

func _ready():
	
	var number_of_powers = GlobalVariables.POWER_UPS.size()
	
	randomize()
	power_1 = randi()%number_of_powers
	power_2 = randi()%number_of_powers

	while(power_1 == power_2):
		power_2 = randi()%number_of_powers
		
	var power_up_arr_1 = GlobalVariables.POWER_UPS[power_1]
	var power_up_arr_2 = GlobalVariables.POWER_UPS[power_2]
	
	for power in power_up_arr_1:
		if power[0] == "PLAYER_SPEED":
			if power[1] > 0:
				$left_card/left_1.frame = 7
			if power[1] < 0:
				$left_card/left_2.frame = 8
		elif power[0] == "PLAYER_LIFE":
			if power[1] > 0:
				$left_card/left_1.frame = 1
			if power[1] < 0:
				$left_card/left_2.frame = 2
		elif power[0] == "PLAYER_DAMAGE":
			if power[1] > 0:
				$left_card/left_1.frame = 3
			if power[1] < 0:
				$left_card/left_2.frame = 4
		elif power[0] == "PLAYER_JUMP_VELOCITY":
			if power[1] < 0:
				$left_card/left_1.frame = 5
			if power[1] > 0:
				$left_card/left_2.frame = 6
	
	for power in power_up_arr_2:
		if power[0] == "PLAYER_SPEED":
			if power[1] > 0:
				$right_card/left_1.frame = 7
			if power[1] < 0:
				$right_card/left_2.frame = 8
		elif power[0] == "PLAYER_LIFE":
			if power[1] > 0:
				$right_card/left_1.frame = 1
			if power[1] < 0:
				$right_card/left_2.frame = 2
		elif power[0] == "PLAYER_DAMAGE":
			if power[1] > 0:
				$right_card/left_1.frame = 3
			if power[1] < 0:
				$right_card/left_2.frame = 4
		elif power[0] == "PLAYER_JUMP_VELOCITY":
			if power[1] < 0:
				$right_card/left_1.frame = 5
			if power[1] > 0:
				$right_card/left_2.frame = 6


func _on_power_1_pressed():
	give_player_power(power_1)
	GlobalVariables.resolution_level -= 1
	next_level() 

func _on_power_2_pressed():
	give_player_power(power_2)
	GlobalVariables.resolution_level -= 1
	next_level() 

func _on_no_power_pressed():
	next_level() 

func give_player_power(index):
	var power_up_arr = GlobalVariables.POWER_UPS[index]
	
	for power in power_up_arr:
		if power[0] == "PLAYER_SPEED":
			GlobalVariables.PLAYER_SPEED += power[1]
		elif power[0] == "PLAYER_LIFE":
			GlobalVariables.PLAYER_LIFE += power[1]
		elif power[0] == "PLAYER_DAMAGE":
			GlobalVariables.PLAYER_DAMAGE += power[1]
		elif power[0] == "PLAYER_JUMP_VELOCITY":
			GlobalVariables.PLAYER_JUMP_VELOCITY += power[1]
		GlobalVariables.PLAYER_POWER_UPS.append(power)
			
func next_level():
	if GlobalVariables.player_on_level == 1:
		GlobalVariables.player_on_level += 1
		get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")
	elif GlobalVariables.player_on_level == 2:
		GlobalVariables.player_on_level += 1
		get_tree().change_scene_to_file("res://scenes/levels/level_3.tscn")
	pass
