extends Node2D

@onready var player = $Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_spawn_in_home()


func player_spawn_in_home() -> void:
	if Global.player_spawn_point != "":
		# 씬 안에서 그 이름을 가진 Marker2D 노드 찾기
		var spawn_node = find_child(Global.player_spawn_point, true, false)
		
		if spawn_node and player:
			# player 위치를 해당 마커의 위치로 이동
			player.global_position = spawn_node.global_position
			
			print("player spawn 위치 확인")
		
		Global.player_spawn_point = ""
