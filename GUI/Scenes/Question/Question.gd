extends Control


onready var time_label = $VBoxContainer/Time
onready var question_no = $VBoxContainer/HBoxContainer/No
onready var question_label = $VBoxContainer/Question
onready var options = [$VBoxContainer/Option1, $VBoxContainer/Option2,
			$VBoxContainer/Option3, $VBoxContainer/Option4]
'⁺'
var charges = {
	"Sodium (Na)": '+1',
	"Potassium (K)": '+1',
	"Silver (Ag)": '+1',
	"Cuprous (Cu)": '+1',
	"Hydrogen (H)": '+1',
	"Hydride (H)": -1,
	"Chloride (Cl)": -1,
	"Bromide (Br)": -1,
	"Iodide (I)": -1,
	"Ammonium (NH₄)": '+1',
	"Hydroxide (OH)": -1,
	"Nitrate (NO₃)": -1,
	"Hydrogen Carbonate (HCO₃)": -1,
	"Magnesium (Mg)": '+2',
	"Calcium (Ca)": '+2',
	"Zinc (Zn)": '+2', 
	"Ferrous (Fe)": '+2',
	"Cuperric (Cu)": '+2',
	"Oxide (O)": -2,
	"Sulphide (S)": -2,
	"Carbonate (CO₃)": -2,
	"Sulphite (SO₃)": -2,
	"sulphate (SO₄)": -2,
	"Aluminium (Al)": "+3",
	"Ferric (Fe)": "+3",
	"Nitride (N)": -3,
	"Phosphate (PO₄)": -3,
}

var correct = "Option 1"
var score = 0
var focused = 0
var back = false
var inc = false
var no = 0
var keys = charges.keys()
var end = false

func _ready():
	randomize()
	keys.shuffle()
	# Connect options to _option_pressed
	for option in options:
		option = option as Button
		option.connect("pressed", self, "_option_pressed", [option])
	_next_question()


func _set_question(question: String, answers: PoolStringArray):
	if !question and answers: return
	# Reset Timer
	time_label.text = "0"
	# Set the Question Text
	question_label.text = question
	question_no.text = str(int(question_no.text)+1)
	# Shuffle the options
	options.shuffle()
	# Set the Answers Text
	for i in answers.size():
		(options[i] as Button).text = answers[i]
	correct = answers[0]
	


func _next_question():
	if no >= keys.size():
		end = true
		return
	var valen = [charges[keys[no]]]
	var avail = [-3, -2, -1, '+1', '+2', '+3']
	avail.erase(valen[0])
	avail.shuffle()
	avail.resize(3)
	valen.append_array(avail)
	_set_question("Charge of " + keys[no], valen)
	no += 1


func _option_pressed(option: Button):
	# Allow only if the option was previously focused
	if option.get_index() != focused:
		focused = option.get_index()
		return
	focused = 0
	option.release_focus()
	# Check if the option was correct
	if option.text == correct:
		if not inc:
			score += 1 # Add score
		inc = false
		$ColorRect/AnimationPlayer.play("Correct")
	else:
		inc = true
		$ColorRect/AnimationPlayer.play("Incorrect")
	back = false


func _on_Timer_timeout():
	# Update timer
	time_label.text = str(int(time_label.text)+1)


func _on_Home_pressed():
	pass # Goto Home


func _on_AnimationPlayer_animation_finished(anim_name):
	if !back:
		if anim_name == "Correct": _next_question()
		$ColorRect/AnimationPlayer.play_backwards(anim_name)
		back = true
	else:
		if end:
			end = false
			$ColorRect/CenterContainer/Label.text = str("Score", score, "/", keys.size())
			$ColorRect/AnimationPlayer.play("Score")
