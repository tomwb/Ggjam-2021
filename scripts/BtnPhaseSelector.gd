extends TextureButton

export(int, "Phase 1", "Phase 2","Phase 3","Phase 4") var phase_number = 1
export(String, FILE) var phase

func _ready():
	visible = false
	if GAME.total_open_scennes > phase_number:
		visible = true
		

func _on_BtnPhase_pressed():
	GAME.changeScenne(phase)
