extends Node

# 플레이어 노드를 담을 전역 변수
var player: CharacterBody2D = null # 처음에는 비어있음
var player_entered_area: String = ""
var player_spawn_point: String = "" # marker2D 이름을 쓰기 때문에 marker2D 노드 이름 설정에 주의
