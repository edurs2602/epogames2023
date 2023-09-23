extends CharacterBody2D

var player = null
var player_chase = false

const SPEED = 80.0
const JUMP_VELOCITY = -400.0

var HEALTH = 30
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if !is_on_floor():
		

	if(player_chase):
		position += (player.position - position)/SPEED

	move_and_slide()
	
func _process(delta):
	pass
		
func take_damage(damage):
	print("tomei do voador")
	HEALTH -= damage
	if HEALTH <= 0:
		self.queue_free()

func _on_hurtbox_area_entered(area):
	take_damage(10)
	
	
func _on_hitbox_body_entered(body):
	if body.has_method("player"):
		body.take_damage(10)


func _on_detection_area_body_entered(body):
	player = body
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
