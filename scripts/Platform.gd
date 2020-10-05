extends StaticBody2D


export(NodePath) var label
export(NodePath) var collider
export(NodePath) var timer


func appear():
	show()
	get_node(label).show()
	get_node(collider).set_disabled(false)

func disappear():
	get_node(label).hide()
	get_node(timer).start(0.5)


func _on_Timer_timeout():
	hide()
	get_node(collider).set_disabled(true)
