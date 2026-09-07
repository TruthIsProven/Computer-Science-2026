extends Node2D

@onready var option_button: OptionButton = $"Answering Panel/MarginContainer/MarginContainer/OptionButton"

class Call:
	var caller_name: String
	var caller_text: String
	var question: String
	var answer: String

	func _init(data: Dictionary):
		caller_name = data.get("caller_name", "")
		caller_text = data.get("caller_text", "")
		question = data.get("question", "")
		answer = data.get("answer", "")

const CALL_FILE = "res://entries/calls.json"

var calls = {}

var current_day = 1
var current_call = 0

var active_call: Call

var correct_answers = 0
var wrong_answers = 0

func _ready() -> void:
	
	# Make sure the correct panels are visible.
	$"Incoming Call".visible = false
	$"Caller info".visible = false
	
	# Start button is visible.
	$MarginContainer/Start_button.visible = true
	
	# Load the calls from the JSON file.
	load_calls()


func load_calls() -> void:
	
	var file = FileAccess.open(CALL_FILE, FileAccess.READ)
	
	if file == null:
		print("Could not find calls.json")
		return
	
	var text = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var error = json.parse(text)
	
	if error != OK:
		print("There is an error in calls.json")
		return
	
	calls = json.data
	
	print("Calls loaded!")

func _on_button_11_pressed() -> void:
	
	# Hide Start Day button.
	$MarginContainer/Start_button.visible = false
	
	# Show Incoming Call panel.
	$"Incoming Call".visible = true
	
	# Load the first call of the current day.
	load_current_call()

func load_current_call() -> void:
	
	var day_name = "day_" + str(current_day)
	
	# Check if the day exists.
	if not calls.has(day_name):
		print("Day does not exist: ", day_name)
		return
	
	# Get all calls for this day.
	var day_calls = calls[day_name]
	
	# Check if there are any calls.
	if current_call >= day_calls.size():
		print("No more calls today.")
		return
	
	# Get this specific call.
	var call_data = day_calls[current_call]
	
	# Turn the JSON data into our Call class.
	active_call = Call.new(call_data)
	
	print("Loaded caller: ", active_call.caller_name)


func _on_pickup_call_pressed() -> void:
	
	$"Incoming Call".visible = false
	$"Caller info".visible = true
	
	# Make sure we actually have a call.
	if active_call == null:
		print("ERROR: No active call!")
		return
	
	# Display the caller's text.
	$"Caller info/MarginContainer/MarginContainer/callertext".text = (
	active_call.caller_name
	+ "\n\n"
	+ active_call.caller_text
	)

func _on_hold_pressed() -> void:
	
	# Hide the caller information.
	$"Caller info".visible = false
	$question_at_top_left.visible = true
	# Here we will eventually show the question.
	# For now, print it so we know it works.
	$question_at_top_left/Top_left_question_display.text = (
	active_call.caller_name
	+ "\n\n"
	+ active_call.caller_text
	)

	if active_call != null:
		print("QUESTION: ", active_call.question)


func _on_exitbutton_pressed() -> void:
	$"Answering Panel".visible = false
	pass # Replace with function body.


func _on_answer_button_pressed() -> void:
	$"Answering Panel".visible = true
	pass # Replace with function body.

func check_player_answer() -> void:

	# Get the option the player selected.
	var selected_answer = option_button.get_item_text(
		option_button.selected
	)

	# Compare it with the correct answer.
	if selected_answer == active_call.answer:

		print("CORRECT!")

		correct_answers += 1

	else:

		print("WRONG!")

		wrong_answers += 1


	# Close the answering panel.
	$"Answering Panel".visible = false

	# Move to the next call.
	go_to_next_call()
	

func _on_confirmbutton_pressed() -> void:
	check_player_answer()
	pass # Replace with function body.
	
func go_to_next_call() -> void:

	# Move to the next call.
	current_call += 1


	var day_name = "day_" + str(current_day)

	var day_calls = calls[day_name]


	# Check if there are more calls today.
	if current_call < day_calls.size():

		print("Loading next call!")

		# Hide the question.
		$question_at_top_left.visible = false

		# Show the incoming call.
		$"Incoming Call".visible = true

		# Load the next call.
		load_current_call()

	else:

		print("Day complete!")

		complete_day()

func complete_day() -> void:

	print("DAY ", current_day, " COMPLETE")

	print("Correct answers: ", correct_answers)

	print("Wrong answers: ", wrong_answers)


	# Move to the next day.
	current_day += 1


	# Go back to the first call.
	current_call = 0


	# Hide the question.
	$question_at_top_left.visible = false


	# Show Start Day again.
	$MarginContainer/Start_button.visible = true
