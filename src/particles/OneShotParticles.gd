extends Particles2D

func _ready():
	one_shot = true
	emitting = true
	
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "queue_free")
	timer.start(lifetime * 1.5)
