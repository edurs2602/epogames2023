extends Area2D

@export var LIFE = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (LIFE <= 0):
		queue_free()

func _on_area_entered(area):
	LIFE -= 10
