extends Node

func _ready():
	yield(get_tree().create_timer(4), "timeout")
	HUD.fade("fadein")
	HUD.connect("fade_finished", self, "_on_fade_finished")

func _on_fade_finished():
	GAME.changeScenneMain()
