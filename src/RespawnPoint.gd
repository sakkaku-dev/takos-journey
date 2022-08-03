extends Area2D


func _on_RespawnPoint_body_entered(body):
	GameState.respawn_point = global_position
