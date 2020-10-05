extends Node2D


export var speed = 10
export(PackedScene) var explosion_scene

var velocity = Vector2()


func _ready():
	position.x = randf() * 2880
	position.y = randf() * 1200 - 1500
	velocity.x = randf() * 8 - 4


func _process(delta):
	velocity.y += speed * delta
	translate(velocity)


func _on_RemoveTimer_timeout():
	queue_free()


func _on_Area2D_body_entered(body):
	var explosion = explosion_scene.instance()
	explosion.global_position = global_position
	get_parent().add_child(explosion)
	queue_free()
