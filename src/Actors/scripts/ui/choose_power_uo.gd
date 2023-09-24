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
	print(GlobalVariables.PLAYER_POWER_UPS)
	pass
