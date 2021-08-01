extends TextureButton

export var upscale_on_hover := false
export var downscale_on_press := false
export var should_scale : bool = true


func _ready() -> void:
	rect_pivot_offset = rect_size * 0.5

	if should_scale:
		connect("mouse_entered", self, "_on_mouse_entered")
		connect("mouse_exited", self, "_on_mouse_exited")

	connect("button_down", self, "_on_button_down")
	connect("button_up", self, "_on_button_up")

	Settings.connect("audio_effects_volume_changed", self, "set_audio_volume")
	set_audio_volume(Settings.audio_effects_volume)


func _on_mouse_entered() -> void:
	if upscale_on_hover:
		_upscale()
	
	if not disabled:
		$HoverSound.play()


func _on_mouse_exited() -> void:
	if upscale_on_hover:
		_reset_scale()


func _on_button_down() -> void:
	if downscale_on_press:
		_downscale()
	
	if not disabled:
		$ClickSound.play()


func _on_button_up() -> void:
	if upscale_on_hover:
		_upscale()
	else:
		_reset_scale()


func _upscale() -> void:
	if not disabled:
		rect_scale = Vector2(1.05, 1.05)


func _downscale() -> void:
	if not disabled:
		rect_scale = Vector2(0.95, 0.95)


func _reset_scale() -> void:
	rect_scale = Vector2.ONE


func set_disabled(dis:bool) -> void:
	disabled = dis
	
	if dis:
		_reset_scale()


func handle_action(action: int) -> void:
	if action == GUISteering.gui_actions.left or action == GUISteering.gui_actions.right:
		return
	
	emit_signal("pressed")

func set_audio_volume(value: float) -> void:
	$HoverSound.set_volume_db(linear2db(value))
	$ClickSound.set_volume_db(linear2db(value))
