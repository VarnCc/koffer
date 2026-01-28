extends Node2D

var aim_value = 0.0
var aim_direction = 1.0
var aim_speed = 1.5
var aim_locked := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		aim_locked = true
	
	if not aim_locked:
		aim_value += aim_direction * aim_speed * delta
		if aim_value >= 1.0:
			aim_value = 1.0
			aim_direction = -1.0
		elif aim_value <= 0.0:
			aim_value = 0.0
			aim_direction = 1.0
		
	print(aim_value)
