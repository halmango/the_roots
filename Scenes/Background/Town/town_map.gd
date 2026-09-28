extends StaticBody2D

var is_player_in_area: bool = false

# Plaer Home Area
func _on_player_home_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_in_area = true
		Global.player_entered_area = "Player Home"
		print("E 키를 눌러 상호작용")
		


func _on_player_home_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_in_area = false
		Global.player_entered_area = ""
		print("상호작용 영역을 벗어남")
