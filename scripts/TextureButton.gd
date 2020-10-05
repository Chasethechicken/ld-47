extends TextureButton


export(PackedScene) var level_1


func _on_StartGame_pressed():
	var level = level_1.instance()
	get_tree().get_root().add_child(level)
	get_parent().hide()


func _on_ButtonQuit_pressed():
	get_tree().quit()
