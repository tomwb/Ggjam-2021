extends CanvasLayer

var text = []
var text_title = ''
signal write_text_finished

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
	$TextModal.visible = false
	$TextModal/LabelTimer.stop()
	$BtnClose.visible = false;
	text = []
	text_title = ''

func setPhaseFormat():
	$BtnClose.visible = true;
