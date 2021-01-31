extends "res://scripts/PlayerBase.gd" 

func player_init():
	HUD.connect("catch_all_letters", self, "on_catch_all_letters")
	HUD.showTextModal('start', [
		"I almost remembered everything",
		"But, it seems that something is missing ....",
		"a key...",
		"Let's find this thing I missed ... What is it?",
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
		$AudioHit.play()
		yield(get_tree().create_timer(1.5),"timeout")
		GAME.set_phase(3)
	if area.is_in_group("Letter") :
		status = STOP
		HUD.showTextModal('letter', [
			"Oh.. a letter",
		])
		
func _on_write_text_finished(title):
	if title == "letter":
		status = IDLE
		
func on_catch_all_letters():
	$AnimationTree.get("parameters/playback").travel("Evolve")
	HUD.evolve("phase4", [
		"Auguste...",
		"AUGUSTE!!!",
		"Oh my!!! That’s my name!!!",
		"I’m a person, I can walk, I can feel the world…I remember WHO I am!!",
		"I am Auguste, this is my engagement day...",
		"This is my life...",
		"Everyday"
	])
	yield(get_tree().create_timer(10), "timeout")
	GAME.finish_screen()
