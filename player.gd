extends Node2D

signal shot_request(locked_direction, powering_value)

var aim_value = 0.0
var aim_direction = 1.0
var aim_speed = 1.0/2.0
var aim_locked := false
var aim_locked_value = 0.0

var power_value = 0.0
var power_speed = 1.0/2.5
var power_direction = 1.0
var powering_value = 0.0

var locked_direction: Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		if Input.is_action_just_pressed("shoot") and not aim_locked:
			aim_locked = true
			aim_locked_value = aim_value
			
			power_value = 0.0
			power_direction = 1.0
			print ("Lock: ", aim_locked_value)
			var direction = angle_calculat()
			locked_direction = direction
		
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
			
		if Input.is_action_just_released("shoot") and aim_locked:
			powering_value = power_value
			emit_signal("shot_request", locked_direction, powering_value)
			aim_locked = false
			power_value = 0.0
			print("Power locked: ", powering_value)
			
		#---Aim Lock
		var show_direction: Vector2
		if not aim_locked:
			var angle = 85 - (aim_value * (85 -5))
			angle = deg_to_rad(angle)
			show_direction = Vector2(cos(angle), -sin(angle))
		else:
			show_direction = locked_direction
		$AimLine.points =[Vector2.ZERO, show_direction.normalized() * 80]
		
		$PowerBarBG/PowerBar.size.x = 60 * power_value

func angle_calculat():
	var angle = 85 - (aim_locked_value * (85 -5))
	angle = deg_to_rad(angle)
	
	var direction = Vector2(cos(angle), -sin(angle))
	return direction
