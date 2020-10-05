extends Node2D


func _on_RemoveTimer_timeout():
	queue_free()
