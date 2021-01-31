extends CanvasLayer

var text = []
var text_title = ''
signal write_text_finished
signal fade_finished
signal evolve_finished
signal catch_all_letters

var total_letters = 0

var evolve_memories = [
	"res://sprites/memory/memorias1.png",
	"res://sprites/memory/memorias2.png",
	"res://sprites/memory/memorias3.png",
	"res://sprites/memory/memorias4.png",
	"res://sprites/memory/memorias5.png"
]

func _ready():
	setMainFormat()
	
func showTextModal(title, newText):
	text_title = title
	if text.size() <= 0:
		text = newText
		changeText()
	elif text.size() > 0:
		text += newText

func changeText():
	if text.size() > 0:
		GAME.game_time = 0
		$TextModal/AudioTyping.play()
		$TextModal/Label.text = text[0]
		text.remove(0)
		$TextModal.visible = true
		$TextModal/LabelTimer.start()
	else:
		GAME.game_time = 1
		$TextModal.visible = false
		emit_signal("write_text_finished", text_title)
		

func _on_LabelTimer_timeout():
	changeText()

func _on_BtnClose_pressed():
	GAME.changeScenneMain()
	
func setMainFormat():
	$Evolve.visible = false
	$TextModal.visible = false
	$TextModal/LabelTimer.stop()
	$BtnClose.visible = false
	$HudName.visible = false
	clear_letter() 
	
func setPhaseFormat():
	$Evolve.visible = false
	$BtnClose.visible = true
	$HudName.visible = false
	text = []
	text_title = ''
	total_letters = 0
	clear_letter()

	
func fade(type):
	$Fade/AnimationFade.play(type)
	yield($Fade/AnimationFade,"animation_finished")
	emit_signal("fade_finished")
	
func evolve(phase, text):
	var texture = evolve_memories[0]
	if (phase == "phase2"):
		texture = evolve_memories[1]
	elif (phase == "phase3"):
		texture = evolve_memories[2]
	elif (phase == "phase4"):
		texture = evolve_memories[3]
	else :
		texture = evolve_memories[0]
		
	fade("fadeinblack")
	$Evolve/SpriteMemorie.texture = load(texture)
	yield($Fade/AnimationFade,"animation_finished")
	showTextModal('finish', text)
	$Evolve.visible = true
	$Evolve/AnimatedSprite.play(phase)

func clear_letter():
	for letter in $HudName.get_children():
		letter.frame = 7
		
func set_letter(value):
	var frame = 7
	if value == "a":
		frame = 0
	elif  value == "u":
		frame = 1
	elif  value == "g":
		frame = 2
	elif  value == "uu":
		frame = 3
	elif  value == "s":
		frame = 4
	elif  value == "t":
		frame = 5
	elif  value == "e":
		frame = 6
	
	$HudName.visible = true
	if $HudName.get_child(frame) :
		total_letters += 1
		$HudName.get_child(frame).frame = frame
		
	if total_letters == 7:
		emit_signal("catch_all_letters")
		
