extends Control


export(NodePath) var platforms
export(NodePath) var markers
export(NodePath) var variable_time
export(NodePath) var variable_difficulty
export(NodePath) var variable_loops_survived
export(PackedScene) var meteor_scene
export(NodePath) var objects
export(PackedScene) var lava_scene
export(NodePath) var lava_position
export(float) var platform_ratio = 0.4
export(float) var tick_time = 1

var level_active = true
var time = 0
var last_tick = 0
var stage = 0
var difficulty = 1
var loops_survived = 0


func _ready():
	randomize()
	setStage(0)
	randomizePlatforms()


func _process(delta):
	time += delta
	get_node(variable_time).text = str(time)
	if time > last_tick + tick_time:
		last_tick = time
		if stage == 1:
			match randi()%3+1:
				1:
					stage = 2
					randomizePlatforms()
				2:
					stage = 3
					meteors(max(1, round(difficulty)))
				3:
					stage = 4
					floorIsLava(difficulty)
		elif stage > 1 and stage < 5:
			stage = 5
			difficulty = difficulty + max(0, randf() * 8 - 5)
			get_node(variable_difficulty).text = str(difficulty)
		elif stage == 5:
			stage = 0
			loops_survived += 1
			get_node(variable_loops_survived).text = str(loops_survived)
		else:
			stage += 1
		setStage(stage)


func setStage(stage):
	for marker in get_node(markers).get_children():
		marker.hide()
	get_node(markers).get_node(str(stage)).show()

func randomizePlatforms():
	for platform in get_node(platforms).get_children():
		if randf() < platform_ratio:
			platform.appear()
		else:
			platform.disappear()
func meteors(amount):
	for i in amount:
		var meteor = meteor_scene.instance()
		get_node(objects).add_child(meteor)

func floorIsLava(duration):
	if get_node(lava_position).get_child_count() > 0:
		var lava = get_node(lava_position).get_child(0)
		lava.get_node("RemoveTimer").wait_time = duration
	else:
		var lava = lava_scene.instance()
		lava.get_node("RemoveTimer").wait_time = duration
		get_node(lava_position).add_child(lava)


func _on_Player_game_over():
	var game_over = get_node("/root/Main/GameOverMenu")
	game_over.init_variables(time, difficulty, loops_survived)
	game_over.show()
	queue_free()
