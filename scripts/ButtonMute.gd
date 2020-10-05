extends TextureButton


export(Texture) var mute
export(Texture) var unmute
export(NodePath) var audio_player


func _on_ButtonMute_pressed():
	var audio = get_node(audio_player)
	if audio.playing:
		audio.playing = false
		texture_normal = unmute
	else:
		audio.playing = true
		texture_normal = mute
