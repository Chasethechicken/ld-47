extends Control


export(String) var comments_page
export(String) var rating_page

export(NodePath) var variable_time
export(NodePath) var variable_difficulty
export(NodePath) var variable_loops_survived

export(NodePath) var main_menu
export(PackedScene) var level_1


func init_variables(time, difficulty, loops_survived):
	get_node(variable_time).text = str(time)
	get_node(variable_difficulty).text = str(difficulty)
	get_node(variable_loops_survived).text = str(loops_survived)


func _on_ButtonPlay_pressed():
	var level = level_1.instance()
	get_tree().get_root().add_child(level)
	hide()


func _on_ButtonShareScore_pressed():
	OS.shell_open(comments_page)


func _on_ButtonExit_pressed():
	get_node(main_menu).show()
	hide()


func _on_ButtonRate_pressed():
	OS.shell_open(rating_page)
