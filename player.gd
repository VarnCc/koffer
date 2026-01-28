extends Node2D

var aim_value = 0.0
var aim_direction = 1.0
var aim_speed = 1.5
var aim_locked := false
var aim_locked_value = 0.0

var power_value = 0.0
var power_speed = 1.0/3.0
var power_direction = 1.0
var set_powering = false
var powering_value = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		if Input.is_action_just_pressed("shoot"):
			aim_locked = true
			aim_locked_value = aim_value
			print ("Lock: ", aim_locked_value)
			var dir = angle_calculat()
			print("direction: ", dir)
		
		if not aim_locked:
			aim_value += aim_direction * aim_speed * delta
			if aim_value >= 1.0:
				aim_value = 1.0
				aim_direction = -1.0
			elif aim_value <= 0.0:
				aim_value = 0.0
				aim_direction = 1.0
		else:
			power_value += power_direction * power_speed * delta
			if power_value <= 0:
				power_value = 0.0
				power_direction = 1.0
			elif power_value >= 1.0:
				power_value = 1.0
				power_direction = -1.0
				
			print ("Power: ", power_value)
			
		if Input.is_action_just_released("shoot"):
			powering_value = power_value
			print("Power locked: ", powering_value)

func angle_calculat():
	var angle = 80 - (aim_locked_value * (80 -10))
	angle = deg_to_rad(angle)
	
	var direction = Vector2(cos(angle), sin(angle))
	return direction
