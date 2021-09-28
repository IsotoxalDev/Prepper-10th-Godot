extends Control


onready var time_label = $VBoxContainer/Time
onready var question_label = $VBoxContainer/Question
onready var options = [$VBoxContainer/Option1, $VBoxContainer/Option2,
			$VBoxContainer/Option3, $VBoxContainer/Option4]

var correct = "Option 1"
var score = 0
var focused = 0

func _ready():
	randomize()
	# Connect options to _option_pressed
	for option in options:
		option = option as Button
		option.connect("pressed", self, "_option_pressed", [option])


func _set_question(question: String, answers: PoolStringArray, correct_idx: int):
		if !question and answers: return
		# Reset Timer
		time_label.text = "0"
		# Set the Question Text
		question_label.text = question
		options.shuffle()
		for i in answers.size():
			(options[i] as Button).text = answers[i]
		correct = answers[correct_idx]


func _option_pressed(option: Button):
	if option.get_index() != focused:
		focused = option.get_index()
		return
	focused = 0
	option.release_focus()
	print("TEST")
	if option.text == correct:
		score += 1
	_set_question("starst", ["1", "2", "3", "4"], 1)
	print(score)


func _on_Timer_timeout():
	time_label.text = str(int(time_label.text)+1)
