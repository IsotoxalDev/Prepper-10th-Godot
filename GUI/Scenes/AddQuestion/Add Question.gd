extends Control

onready var question = $VBoxContainer/Question
onready var options = [$VBoxContainer/Option1, $VBoxContainer/Option2,
					$VBoxContainer/Option3, $VBoxContainer/Option4]

var data = []


func _add_to_data():
	# Add Data to the var Data
	var answers = []
	for i in options:
		answers = i.text
		i.text = ""
#	data.append({"Q": question.text, "A": answers})
	# Clear Fields


func _on_Done_pressed():
	_add_to_data()
