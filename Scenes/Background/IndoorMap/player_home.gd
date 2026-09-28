extends StaticBody2D

var is_player_in_area: bool = false

func _on_door_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_in_area = true
		Global.player_entered_area = "Player Home Door Area"
		print(Global.player_entered_area, " E 키를 눌러 상호작용")
