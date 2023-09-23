
extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var LIFE = 100
@export var DAMAGE = 10
@onready var attack_collision_hitbox = $attack_hitbox/attack_collision
@onready var timer = $attack_hitbox/Timer
@onready var position2D=$Marker2D/Sprite2D

var enemy_on_hitbox = null
var is_player_alive = true
var position_between_player_enemy = null

# Knockback variables
var knockback_vector = Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func player():
	pass

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector

	move_and_slide()

func _process(delta):
	
	if Input.is_action_just_pressed("shift"):
		attack_collision_hitbox.disabled = false
		timer.start()
		attack()
	
	if Input.is_action_just_pressed("ui_left"):
		if attack_collision_hitbox.position.x > 0:
			attack_collision_hitbox.position.x *= -1
		position2D.flip_h = true
	if Input.is_action_just_pressed("ui_right"):
		if attack_collision_hitbox.position.x < 0:
			attack_collision_hitbox.position.x *= -1
		position2D.flip_h = false
		
		
func take_damage(damage_count):
	
	LIFE -= damage_count
	print(LIFE)
	var health_bar = get_node("/root/main_node/healthBar")
	health_bar.value -= damage_count
	if (LIFE <= 0):
		queue_free()

func attack():
	print("attack")
	if enemy_on_hitbox:
		print(enemy_on_hitbox)
		enemy_on_hitbox.take_damage(DAMAGE)



func _on_attack_hitbox_body_entered(body):
	print("entrou")
	if body.has_method("enemy"):
			enemy_on_hitbox = body


func _on_attack_hitbox_body_exited(body):
		if body.has_method("enemy"):
			enemy_on_hitbox = null


func _on_timer_timeout():
	attack_collision_hitbox.disabled = true
	
		
		
