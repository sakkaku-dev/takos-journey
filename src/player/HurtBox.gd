extends Area2D

signal damaged()

func damage():
	emit_signal("damaged")
