extends Node

var game_time = 1
var total_open_scennes = 4

func changeScenne(newScenne):
	HUD.setPhaseFormat()
	get_tree().change_scene(newScenne)
	
func changeScenneMain():
	HUD.setMainFormat()
	get_tree().change_scene("res://scennes/levels/Main.tscn")

func allow_phase(total):
	total_open_scennes = total
