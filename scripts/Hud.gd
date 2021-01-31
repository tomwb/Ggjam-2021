extends CanvasLayer

var text = []
var text_title = ''
signal write_text_finished
signal fade_finished
signal evolve_finished

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
	
func setLevelFormat():
	$Evolve.visible = false
	$BtnClose.visible = true
	text = []
	text_title = ''

func setPhaseFormat():
	$BtnClose.visible = true;
	
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
	

