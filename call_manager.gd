class_name CallManager
extends RefCounted


const CALLS_FILE_PATH := "res://calls/calls.json"


var calls_data: Dictionary = {}
var current_day: int = 1
var current_call_index: int = 0


func load_calls() -> void:
	if not FileAccess.file_exists(CALLS_FILE_PATH):
		push_error("Calls file not found.")
		return

	var file := FileAccess.open(CALLS_FILE_PATH, FileAccess.READ)

	if file == null:
		push_error("Could not open calls file.")
		return

	var json_text := file.get_as_text()
	file.close()

	var json := JSON.new()
	var result := json.parse(json_text)

	if result != OK:
		push_error("Could not parse calls JSON.")
		return

	calls_data = json.data

func get_calls_for_day(day: int) -> Array:
	var day_key := "day_" + str(day)

	if not calls_data.has(day_key):
		push_warning("No calls found for " + day_key)
		return []

	return calls_data[day_key]

func get_current_call() -> CallData:
	var day_calls := get_calls_for_day(current_day)

	if day_calls.is_empty():
		return null

	if current_call_index >= day_calls.size():
		return null

	var call_dictionary: Dictionary = day_calls[current_call_index]

	return CallData.new(call_dictionary)
	
	
