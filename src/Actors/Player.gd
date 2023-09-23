extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var LIFE = 10
@export var DAMAGE = 10

var enemy_on_hitbox = null
var is_player_alive = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func player():
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("shift"):
		attack()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func take_damage(damage_count):
	LIFE -= damage_count
	print(LIFE)
	var health_bar = get_node("/root/main_node/healthBar")
	health_bar.value -= damage_count

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
