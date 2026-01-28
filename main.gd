extends Node2D
@export var target_scene: PackedScene
@export var projectile_scene: PackedScene

var score = 0
var combo = 1
const target_points = 10.0
var game_state = true
var shot_active = false
var target_active = false
var current_target: Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_target()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		test_shoot()

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
		
		current_target = target
		add_child(target)

func projectile():
	var projectile = projectile_scene.instantiate()
	add_child(projectile)
	projectile.global_position = $PlayerSpawn.global_position
	projectile.linear_velocity = Vector2(400, -500)
	
	projectile.hit.connect(_on_projectile_hit)
	projectile.miss.connect(_on_projectile_miss)
	projectile.out_of_view.connect(_on_projectile_out_of_view)

func _on_projectile_hit():
	print("hit")
	score += target_points * combo
	combo += 0.1
	
	current_target.queue_free()
	current_target = null
	target_active = false
	spawn_target()
	
	shot_active = false
	
func _on_projectile_miss():
	print("miss")
	combo = 1.0
	
	shot_active = false
	
func _on_projectile_out_of_view():
	print("miss")
	combo = 1.0
	
	shot_active = false
	
func test_shoot():
	if shot_active == false:
		projectile()
		shot_active = true
