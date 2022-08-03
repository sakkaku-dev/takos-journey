extends Node

var respawn_point: Vector2
var holding_book = false

func _ready():
	for player in get_tree().get_nodes_in_group("Player"):
		respawn_point = player.global_position

func load_game_state():
	for player in get_tree().get_nodes_in_group("Player"):
		player.holding_book = holding_book
		player.global_position = respawn_point
