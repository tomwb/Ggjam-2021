extends TextureButton

export(String, FILE) var phase

func _ready():
	pass

func _on_BtnPhase_pressed():
	GAME.changeScenne(phase)
