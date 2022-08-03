class_name Interact extends Area2D

signal interacted(type)

enum Type {
	BOOK
}

func interact():
	var areas = get_overlapping_areas()
	if areas:
		var interactable = areas[0]
		var type = interactable.get_interact_type()
		emit_signal("interacted", type)
