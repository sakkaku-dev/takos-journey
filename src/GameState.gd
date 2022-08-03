extends Node

var respawn_point: Vector2

func _ready():
	for player in get_tree().get_nodes_in_group("Player"):
		respawn_point = player.global_position
