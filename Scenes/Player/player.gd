extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var speed: int = 150
@export var iris_loading: PackedScene

@export_file("*.tscn") var target_scene: String


func _ready() -> void:
	# 클로벌 스크립트의 player 변수에 자기 자신을 할당하기
	Global.player = self
	# 플레이어가 죽거나 씬에서 제거 될 때 Global.player = null 구문으로 메모리 누수나 에러를 방지해야 함
	# player_reset() 호출하기

func _process(delta: float) -> void:
	var move_vector = get_move_vector()
	var direction = move_vector.normalized()
	
	velocity = speed * direction
	move_and_slide()
	
	play_move_animation()
	player_enter_building()
	player_exit_building()


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


func play_iris_out_loading(target: String) -> void:
	var loading = iris_loading.instantiate()
	loading.target_scene = target
	add_child(loading)


func player_enter_building() -> void:
	if Global.player_entered_area == "Player Home":
		if Input.is_action_just_pressed("interact"):
			target_scene = "res://Scenes/Background/IndoorMap/player_in_home.tscn"
			Global.player_spawn_point = "PlayerHomeSpawnPoint"
			play_iris_out_loading(target_scene)


func player_exit_building() -> void:
	if Global.player_entered_area == "Player Home Door Area":
		if Input.is_action_just_pressed("interact"):
			Global.player_spawn_point = "PlayerHomeToTownSpawnPoint"
			target_scene = "res://Scenes/Background/Town/player_in_town.tscn"
			play_iris_out_loading(target_scene)


func player_reset() -> void:
	Global.player = null
