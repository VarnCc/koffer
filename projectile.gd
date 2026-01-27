extends RigidBody2D
var finished := false

func _physics_process(delta: float) -> void:
	rotation = linear_velocity.angle()
	var screen_size = get_viewport_rect().size
	
	if position.x < 0 or position.x > screen_size.x +20:
		print("Outof view")
		queue_free()
		emit_signal("Out_of_View")
		if finished:
			return
		finished = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("GroundBody"):
		if finished:
			return
		finished = true
		print("Miss (hit body): ", body.name)
		queue_free()
