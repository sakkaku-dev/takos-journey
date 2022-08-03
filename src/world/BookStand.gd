extends Node2D

onready var book := $Book
onready var interactable := $Interactable

func _ready():
	if GameState.holding_book:
		_on_Interactable_interacted()

func _on_Interactable_interacted():
	book.visible = false
	interactable.monitorable = false
