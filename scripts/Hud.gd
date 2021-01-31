extends CanvasLayer

var text = []
var text_title = ''
signal write_text_finished
signal fade_finished
signal evolve_finished

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
	$BtnClose.visible
	
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
	fade("fadeinblack")
	yield($Fade/AnimationFade,"animation_finished")
	showTextModal('finish', text)
	$Evolve.visible = true
	$Evolve/AnimatedSprite.play(phase)
	

