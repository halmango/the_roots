extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect

var player: CharacterBody2D
var shader_mat: ShaderMaterial

func _ready() -> void:
	shader_mat = color_rect.material as ShaderMaterial
	
	# 부모 노드를 플레이어로 인식
	player = get_parent()
	
	# 화면 종횡비 계산 후 셰이더에 전달
	var viewport_size = get_viewport().get_visible_rect().size
	shader_mat.set_shader_parameter("screen_ratio", viewport_size.x / viewport_size.y)
	
	start_iris_out(2.0) # 씬이 시작되면 2초 동안 닫힘


func _process(_delta: float) -> void:
	if player and is_instance_valid(player):
		# 플레이어의 월드 좌표를 화면 픽셀 좌표로 변환
		var screen_pos = player.get_global_transform_with_canvas().origin
		var viewport_size = get_viewport().get_visible_rect().size
		
		# 픽셀 좌표를 셰이더용 UV 비율(0.0 ~ 1.0)로 변환
		var uv_pos = screen_pos / viewport_size
		shader_mat.set_shader_parameter("player_position", uv_pos)


# 원을 줄여 화면을 검게 만드는 함수 (로딩 시작 전 연출)
func start_iris_out(duration: float) -> void:
	var tween = create_tween()
	# 셰이더의 circle_size를 1.05에서 0.0으로 서서히 감소시킴
	tween.tween_property(shader_mat, "shader_parameter/circle_size", 0.0, duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
		
	# 애니메이션이 끝나면 다음 씬 로딩 로직 실행
	tween.finished.connect(func():
		print("화면이 완전히 어두워졌습니다. 여기서 비동기 로딩을 시작하세요.")
		# 예: ResourceLoader.load_threaded_request(next_scene_path)
	)
