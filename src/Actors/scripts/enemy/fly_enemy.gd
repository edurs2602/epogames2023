extends CharacterBody2D

@onready var position2D=$Marker2D/Sprite2D
@onready var timer=$Timer

var player = null
var player_chase = false

const SPEED = 80.0
const JUMP_VELOCITY = -400.0
var HEALTH = 7

var directionYIdle = 2
var yDelta = 1
var is_enemy_on_floor = null
var timing_fly = null
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$Marker2D/AnimatedSprite2D.play("fly")
	timer.start()

func _physics_process(delta):
	if is_on_floor():
		is_enemy_on_floor = true
	else:
		is_enemy_on_floor = false
		
	
		
	if !is_enemy_on_floor and !player_chase:
		#velocity.y += (directionYIdle * SPEED) * delta
		#velocity.y = move_toward(position.y, position.y - 2, delta * yDelta)
		pass
		
	if(player_chase):
		position += (player.position - position)/SPEED
		
		if (player.position.x - position.x) > 0:
			$Marker2D/AnimatedSprite2D.flip_h = true
		else:
			$Marker2D/AnimatedSprite2D.flip_h = false
			

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


func _on_timer_timeout():
	yDelta *= -1
