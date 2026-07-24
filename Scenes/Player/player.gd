extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var speed: int = 300

func _process(delta: float) -> void:
	var move_vector = get_move_vector()
	var direction = move_vector.normalized()
	
	velocity = speed * direction
	move_and_slide()
	
	play_move_animation()


func get_move_vector() -> Vector2:
	var x = Input.get_axis("move_left", "move_right")
	var y = Input.get_axis("move_up", "move_down")
	
	return Vector2(x, y)


func play_move_animation() -> void:
	var current_animation = ""

	if Input.is_action_pressed("move_up"):
		current_animation = "walk_up"
	elif Input.is_action_pressed("move_down"):
		current_animation = "walk_down"
	elif Input.is_action_pressed("move_left"):
		current_animation = "walk_left"
	elif Input.is_action_pressed("move_right"):
		current_animation = "walk_right"

	if current_animation != "":
		if animation_player.current_animation != current_animation:
			animation_player.play(current_animation)
	else:
		animation_player.stop()
