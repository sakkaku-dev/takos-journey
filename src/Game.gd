extends Node

onready var player := $Player

func _ready():
	player.global_position = GameState.respawn_point

func _on_Player_died():
	SceneManager.reload_scene()
