extends Node

onready var player := $Player

func _ready():
	GameState.load_game_state()

func _on_Player_died():
	SceneManager.reload_scene()
