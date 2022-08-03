class_name Interactable extends Area2D

signal interacted()

export(Interact.Type) var type: int

func get_interact_type():
	emit_signal("interacted")
	return type
