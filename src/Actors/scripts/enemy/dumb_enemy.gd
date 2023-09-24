extends CharacterBody2D

@export var SPEED = -100
var HEALTH = 5

@export var is_facing_right = true
var enemy_can_attack = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play("walking")

func enemy():
	pass

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if !$ray_down.is_colliding() and is_on_floor():
		flip()
	elif $ray_front.is_colliding() and is_on_floor():
		flip()
	velocity.x = SPEED
	move_and_slide()

func flip():
	is_facing_right = !is_facing_right
	scale.x = abs(scale.x) * -1
	if is_facing_right:
		SPEED = abs(SPEED) * -1
	else:
		SPEED = abs(SPEED) 

func _on_hitbox_body_entered(body):
	if body.has_method("player") and enemy_can_attack:
		body.take_damage(30)
		$attack_cooldown.start()

func _on_attack_cooldown_timeout():
	enemy_can_attack = true
	
func take_damage(damage):
	print("tomei")
	HEALTH -= damage
	if HEALTH <= 0:
		self.queue_free()

func _on_hurtbox_area_entered(area):
	take_damage(10)
