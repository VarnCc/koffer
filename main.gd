extends Node2D
@export var target_scene: PackedScene

var score = 0
var combo = 1
var target_points = 10.0
var game_state = true
var shot_active = false
var target_active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_target()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_target():
	var padding = 18.0
	
	if target_active == false:
		target_active = true
		
		var min_x = $TargetSpawnTopLeft.position.x + padding
		var max_x = $TargetSpawnBotRight.position.x - padding
		
		var min_y = $TargetSpawnTopLeft.position.y + padding
		var max_y = $TargetSpawnBotRight.position.y - padding
		
		var random_x = randf_range(min_x, max_x)
		var random_y = randf_range(min_y, max_y)
		
		var target = target_scene.instantiate()
		var target_spawn_location = Vector2(random_x, random_y)
		target.position = target_spawn_location
		
		add_child(target)
	elif target_active == true:
		return
	else:
		return
