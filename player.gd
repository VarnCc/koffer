extends Node2D

var aim_value = 0.0
var aim_direction = 1.0
var aim_speed = 1.5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	aim()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func aim():
	var run = true
	while run:
		aim_value += aim_direction * aim_speed * get_process_delta_time()
		print(aim_value)
		if aim_direction <= 0.00:
			aim_direction + 0.02
		if aim_direction >= 1.00:
			aim_direction - 0.02
