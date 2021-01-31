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
	if area.is_in_group("SpikeBall") || area.is_in_group("ThunderBall"):
		status = DEAD
		$AnimationTree.get("parameters/playback").travel("Hit")
		yield(get_tree().create_timer(1.5),"timeout")
		GAME.set_phase(2)
	if area.is_in_group("ButtonEvent") :
		area.is_off = true
	if area.is_in_group("MemoryItem") :
		area.connect("collected_animation_finished", self, "_on_finished")
		area.destroy()
		status = EVOLVE
		

func _on_finished():
	$AnimationTree.get("parameters/playback").travel("Evolve")
	HUD.evolve("phase3", [
		"I...I...Remember!!!",
		"it's my graduation!!!",
		"Now I can go my way safely",
	])
	yield(get_tree().create_timer(10), "timeout")
	GAME.set_phase(3)


func _on_CallTextArea_area_entered(area):
	HUD.showTextModal('start', [
		"I need to find a way to turn these rays off..",
	])
	area.queue_free()
