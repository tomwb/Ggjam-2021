extends "res://scripts/PlayerBase.gd"

var preset_inputs = [
	{
		down = "ui_down",
		up = "ui_up",
		left = "ui_left",
		right = "ui_right"
	},
	{
		down = "ui_up",
		up = "ui_down",
		right = "ui_left",
		left = "ui_right",
	},
	{
		down = "ui_up",
		up = "ui_left",
		right = "ui_down",
		left = "ui_right",
	},
	{
		down = "ui_right",
		right = "ui_down",
		up = "ui_left",
		left = "ui_up",
	},
	{
		down = "ui_left",
		up = "ui_right",
		left = "ui_down",
		right = "ui_up",
	},
]
var selected_input = 0

func player_init():
	HUD.showTextModal('start', [
		"I need to continue to find out more...",
		"I need to find myself...",
	])
	
func get_direction():
	var my_input = preset_inputs[selected_input]
	direction = Vector2()
	direction.y = Input.get_action_strength(my_input.down) - Input.get_action_strength(my_input.up)
	direction.x = Input.get_action_strength(my_input.right) - Input.get_action_strength(my_input.left)
	direction.normalized()

func hitted():
	$AnimationTree.get("parameters/playback").travel("Hit")
	yield(get_tree().create_timer(1.5),"timeout")
	status = IDLE

func animations(direction):
	if direction != Vector2.ZERO:
		$AnimationTree.set("parameters/Walk/blend_position", direction)
		$AnimationTree.set("parameters/Idle/blend_position", direction)
	if status == WALK:
		$AnimationTree.get("parameters/playback").travel("Walk")
	elif status == IDLE :
		$AnimationTree.get("parameters/playback").travel("Idle")
		
func _on_CollectorArea2D_area_entered(area):
	if area.is_in_group("MemoryItem") :
		status = EVOLVE
		$AnimationTree.get("parameters/playback").travel("Evolve")
		HUD.showTextModal('finish', [
			"I...I...Remember!!!",
			"it's like riding a bike!!!",
			"Now I can go my way safely",
		])
		area.destroy()
		
func _on_write_text_finished(title):
	print(title)
	if title == 'finish':
		GAME.set_phase(2)

func _on_ChangeControlsTimer_timeout():
	if status == IDLE || status == WALK:
		var new_input = rand_range(1, preset_inputs.size() - 1)
		selected_input = new_input
		HUD.showTextModal('start', [
			"....What!! My Movements....",
		])
