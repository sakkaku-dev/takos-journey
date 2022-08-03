extends Area2D

func _ready():
	connect("area_entered", self, "_on_area_entered")
	
func _on_area_entered(area: Node2D):
	if area.has_method("damage"):
		area.damage()
