extends "res://scripts/PlayerBase.gd" 

func player_init():
	$AnimatedSprite.play("idle")
	HUD.showTextModal('start', [
		"....",
		".......",
		"...Wh-...What…",
		"What am I ?",
		"I ... I ... have been here before …"
	])
	
func hitted():
	$AnimatedSprite.play("hit")
	$AnimationLightMask.play("show")
	# quando a animação acabar
	yield($AnimatedSprite,"animation_finished")
	status = IDLE
	
func animations():
	if status == WALK:
		$AnimatedSprite.play("walk")
	elif status == IDLE :
		$AnimatedSprite.play("idle")

func _on_CollectorArea2D_area_entered(area):
	if area.is_in_group("MemoryItem") :
		area.destroy()
		$AnimatedSprite.play("evolve")
		$AnimationLightMask.play("finish")
		status = EVOLVE
		HUD.showTextModal('finish', [
			"I...I...Remember!!!",
			"I Am a person!!!",
			"This is my Childhood!!",
			"I need to go deeper…"
		])

func _on_write_text_finished(title):
	if title == 'finish':
		GAME.allow_phase(2)
		GAME.changeScenne(next_phase)
		
func _on_TimerMidleText_timeout():
	HUD.showTextModal('midle', [
		"This place... is Familiar…",
		"I have to get out here",
		"I need to find my way…"
	])
