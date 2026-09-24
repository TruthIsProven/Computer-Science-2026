class_name CT_Credits
extends VBoxContainer

signal credits_finished

@export var credits_data: Resource

var _velocity: float
var _is_scrolling: bool = false


func _ready() -> void:
	$CreditsStaff.load_data(credits_data.data)
	set_scroll_velocity( credits_data.data.velocity )

	$CreditsPool.removed_item.connect(add_scroll)

	move_scroll_to_start()
	start()


func _process(delta: float) -> void:
	if(_is_scrolling):
		add_scroll(-_velocity * delta)


func move_scroll_to_start() -> void:
	self.position.y = get_viewport_rect().size.y


func start() -> void:
	_is_scrolling = true


func stop() -> void:
	_is_scrolling = false


func add_scroll(_y: float) -> void:
	self.position.y += _y


func set_scroll_velocity(velocity: float) -> void:
	self._velocity = max(0.001, velocity)


func credits_ended(offset: float) -> void:
	stop()
	self.position.y -= offset
	credits_finished.emit()


func _on_credits_finished() -> void:
	$"../game_ended".visible = true
	pass # Replace with function body.

func _on_restart_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Starting Screen.tscn")
	pass # Replace with function body

func _on_exit_game_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
