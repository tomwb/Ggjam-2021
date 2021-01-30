extends TextureButton

export(int, "Phase 1", "Phase 2","Phase 3","Phase 4") var phase_number = 0

func _ready():
	visible = false
	if GAME.total_open_scennes >= phase_number:
		visible = true
		

func _on_BtnPhase_pressed():
	GAME.set_phase(phase_number)
