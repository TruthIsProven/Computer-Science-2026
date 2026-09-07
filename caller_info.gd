extends Control

# CALL DATA CLASS
# This class represents ONE phone call.
class CallData:
	var id: String
	var caller_name: String
	var caller_text: String
	var question: String
	var correct_answer: String

	func _init(data: Dictionary) -> void:
		id = data.get("id", "")
		caller_name = data.get("caller_name", "Unknown Caller")
		caller_text = data.get("caller_text", "")
		question = data.get("question", "")
		correct_answer = data.get("correct_answer", "")

# FILE PATH
const CALLS_FILE_PATH := "res://entries/calls.json"

# UI REFERENCES
@onready var rich_text_label: RichTextLabel = $MarginContainer/MarginContainer/callertext

# GAME DATA
var calls_data: Dictionary = {}

var current_day: int = 1
var current_call_index: int = 0

var current_call: CallData

func load_calls() -> void:

	# Check if the file exists.
	if not FileAccess.file_exists(CALLS_FILE_PATH):
		push_error("Could not find calls.json at: " + CALLS_FILE_PATH)
		return
	# Open the JSON file.
	var file = FileAccess.open(CALLS_FILE_PATH, FileAccess.READ)
	if file == null:
		push_error("Could not open calls.json")
		return
	# Read everything inside the file.
	var json_text = file.get_as_text()
	file.close()
	# Create a JSON reader.
	var json = JSON.new()
	# Try to read the JSON.
	var result = json.parse(json_text)
	# Check for errors.
	if result != OK:
		push_error(
			"JSON Error on line "
			+ str(json.get_error_line())
			+ ": "
			+ json.get_error_message()
		)
		return
	# Make sure the JSON contains a Dictionary.
	if not json.data is Dictionary:
		push_error("calls.json must start with a Dictionary.")
		return
	# Store all of the calls.
	calls_data = json.data

	print("Calls loaded successfully!")
	print(calls_data)

# GET THE CURRENT CALL

func load_current_call() -> bool:

	# Create the day name.
	# Example: current_day = 1
	# This becomes "day_1"
	var day_key = "day_" + str(current_day)
	# Check if that day exists.
	if not calls_data.has(day_key):
		push_error("Could not find: " + day_key)
		return false

	# Get all calls for this day.
	var day_calls = calls_data[day_key]
	# Check if the call index exists.
	if current_call_index >= day_calls.size():
		push_error("No more calls available for " + day_key)
		return false

	# Get the dictionary for this specific call.
	var call_dictionary = day_calls[current_call_index]
	# Turn the dictionary into a CallData object.
	current_call = CallData.new(call_dictionary)
	print("Loaded call: " + current_call.caller_name)
	return true
# DISPLAY THE CALLER INFORMATION

func show_current_call() -> void:

	# Make sure a call has been loaded.
	if current_call == null:
		push_error("No current call has been loaded!")
		return
	# Show this UI.
	show()
	# Display the information.
	rich_text_label.bbcode_enabled = true

	rich_text_label.text = (
		"[center]"
		+ "[font_size=28][b]"
		+ current_call.caller_name
		+ "[/b][/font_size]\n\n"
		+ current_call.caller_text
		+ "[/center]"
	)
# START THE CURRENT CALL

# You will call this when the player starts the day.
func start_current_call() -> void:

	var success = load_current_call()

	if success:
		show_current_call()
# MOVE TO THE NEXT CALL
func next_call() -> void:
	# Move to the next call.
	current_call_index += 1
# MOVE TO THE NEXT DAY

func next_day() -> void:

	current_day += 1

	# Start from the first call again.
	current_call_index = 0
# GET THE CURRENT QUESTION
func get_current_question() -> String:
	if current_call == null:
		return ""

	return current_call.question
# CHECK THE PLAYER'S ANSWER
func check_answer(player_answer: String) -> bool:

	if current_call == null:
		push_error("There is no current call!")
		return false


	if player_answer == current_call.correct_answer:
		return true

	return false
