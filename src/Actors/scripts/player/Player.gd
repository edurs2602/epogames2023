
extends CharacterBody2D

@export var SPEED = GlobalVariables.PLAYER_SPEED
@export var JUMP_VELOCITY = GlobalVariables.PLAYER_JUMP_VELOCITY
@export var LIFE = GlobalVariables.PLAYER_LIFE
@export var DAMAGE = GlobalVariables.PLAYER_DAMAGE


@onready var attack_collision_hitbox = $attack_hitbox/attack_collision
@onready var attack_timer = $attack_hitbox/Attack_timer
@onready var animated_sprite=$Marker2D/AnimatedSprite2D
@onready var raycast_right = $raycast_right
@onready var raycast_left = $raycast_left
@onready var sound_step = $Sound_step
@onready var step_timer = $Sound_step/Step_timer
@onready var sound_jump = $Sound_jump
@onready var sound_attack = $Sound_attack 
@onready var sound_dead = $Sound_dead
@onready var sound_hurt = $Sound_hurt

var enemy_on_hitbox = null
var is_player_alive = true
var position_between_player_enemy = null
var knockback_vector := Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func player():
	pass

func change_dir(dir): 
	pass


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		sound_jump.play()
		velocity.y = JUMP_VELOCITY

	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if is_on_floor():
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") :
			if step_timer.time_left <= 0:
				sound_step.play()
				step_timer.start()
	
	
	if knockback_vector != Vector2.ZERO:
		print(knockback_vector)
		velocity = knockback_vector

	animating_sprite()

	move_and_slide()

func _process(delta):
	
	if Input.is_action_just_pressed("shift"):
		if attack_timer.time_left <= 0:
			sound_attack.play()
			attack_collision_hitbox.disabled = false
			attack_timer.start()
			attack()
	
	if Input.is_action_just_pressed("ui_left"):
		if attack_collision_hitbox.position.x > 0:
			attack_collision_hitbox.position.x *= -1
		animated_sprite.flip_h = true
	if Input.is_action_just_pressed("ui_right"):
		if attack_collision_hitbox.position.x < 0:
			attack_collision_hitbox.position.x *= -1
		animated_sprite.flip_h = false


func receive_knockback(knockback_force : Vector2, damage := true, duration := .3):
	
	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		var tween = get_tree().create_tween()
		tween.parallel().tween_property(self,"knockback_vector",Vector2.ZERO,duration)
		
		if damage:
			animated_sprite.modulate = Color(1,0,0,1)
			tween.parallel().tween_property(animated_sprite,"modulate",Color(1,1,1,1),duration)


func take_damage(damage_count: int ):
	LIFE -= damage_count
	
	sound_hurt.play()
	
	if raycast_right.is_colliding():
		receive_knockback(Vector2(-200,-200))
	elif raycast_left.is_colliding():
		receive_knockback(Vector2(200,-200))
		
	animated_sprite.play("damage")
	var health_bar = get_node("/root/main_node/healthBar")
	health_bar.value -= damage_count
	
	if (LIFE <= 0):
		sound_dead.play()
		animated_sprite.play("dying")
		self.set_process(false)
		self.set_physics_process(false)


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


func animating_sprite():
	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("going_up")
		elif velocity.y > 0:
			animated_sprite.play("going_down")
	elif velocity.x != 0:
		animated_sprite.play("walking")
	else:
		animated_sprite.play("idle")


func _on_animated_sprite_2d_animation_looped():
	if animated_sprite.animation == "dying":
		animated_sprite.pause()
		animated_sprite.set_frame_and_progress(2,0)


func _on_step_timer_timeout():
	pass
