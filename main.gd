extends Node2D
@export var target_scene: PackedScene
@export var projectile_scene: PackedScene
@export var player_scene: PackedScene

var time_left = 60.0
var score = 0
var combo = 1.0
const target_points = 10.0
var game_state = true
var shot_active = false
var target_active = false
var current_target: Node = null
var player: Node = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_round()
	spawn_player()
	spawn_target()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_left = $GameTimer.time_left
	print($GameTimer.time_left)

func start_round():
	time_left = 60.0
	$GameTimer.start(60.0)
	if player:
		player.set_input_enabled(true)

func end_round():
	if player:
		player.set_input_enabled(false)

func _on_game_timer_timeout() -> void:
	end_round()

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

func projectile(direction, power):
	var projectile = projectile_scene.instantiate()
	add_child(projectile)
	projectile.global_position = $PlayerSpawn.global_position
	
	var base_speed = 800.0
	base_speed = base_speed * power
	projectile.linear_velocity = direction * base_speed
	
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
	$Player.can_charge = true
	
func _on_projectile_miss():
	print("miss")
	combo = 1.0
	
	shot_active = false
	$Player.can_charge = true
	
func _on_projectile_out_of_view():
	print("miss")
	combo = 1.0
	
	shot_active = false
	$Player.can_charge = true

func _on_player_shot_request(direction: Vector2, power: float):
	if shot_active:
		return
	projectile(direction, power)
	shot_active = true

func spawn_player():
	player = player_scene.instantiate()
	add_child(player)
	player.global_position = $PlayerSpawn.global_position
	player.shot_request.connect(_on_player_shot_request)
