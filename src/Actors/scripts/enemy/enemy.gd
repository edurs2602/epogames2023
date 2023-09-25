extends CharacterBody2D

@export var SPEED = 100
var HEALTH = 8

var player = null
var player_chase = false

var enemy_can_attack = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play("idle")

func enemy():
	pass

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if(player_chase):
		position += (player.position - position)/SPEED
		if (player.position.x - position.x) > 0:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false
			
	
	move_and_slide()

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
	animated_sprite.play("walking")
	

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
	animated_sprite.play("idle")

func _on_hitbox_body_entered(body):
	if body.has_method("player") and enemy_can_attack:
		body.take_damage(2)
		$attack_cooldown.start()

func _on_attack_cooldown_timeout():
	enemy_can_attack = true
	
func take_damage(damage):
	print("tomei")
	HEALTH -= damage
	if HEALTH <= 0:
		self.queue_free()


func _on_hurtbox_area_entered(area):
	take_damage(GlobalVariables.PLAYER_DAMAGE)
