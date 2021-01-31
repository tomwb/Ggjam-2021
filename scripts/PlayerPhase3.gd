extends "res://scripts/PlayerBase.gd" 

func player_init():
	HUD.showTextModal('start', [
		"Now I can move properly...",
		"Finally I can find out who I am",
	])
	
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
			"it's my graduation!!!",
			"Now I can go my way safely",
		])
		area.destroy()
		
func _on_write_text_finished(title):
	if title == 'finish':
		GAME.set_phase(4)
