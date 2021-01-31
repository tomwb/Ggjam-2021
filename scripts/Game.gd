extends Node

var game_time = 1
var total_open_scennes = 0

var all_scennes = [
	"res://scennes/levels/Phase1.tscn",
	"res://scennes/levels/Phase2.tscn",
	"res://scennes/levels/Phase3.tscn",
	"res://scennes/levels/Phase4.tscn"
]

var main_scenne = "res://scennes/levels/Main.tscn"

func changeScenne(index):
	if all_scennes.size() > index:
		get_tree().change_scene(all_scennes[index])
		HUD.fade("fadeoutblack")
		HUD.setPhaseFormat()
	
func changeScenneMain():
	get_tree().change_scene(main_scenne)
	HUD.setMainFormat()

func set_phase(total):
	if total_open_scennes <= total:
		total_open_scennes = total
	changeScenne(total)
	
func finish_screen():
	get_tree().change_scene("res://scennes/levels/Main.tscn")
	HUD.fade("fadeoutblack")
	HUD.setPhaseFormat()
	
