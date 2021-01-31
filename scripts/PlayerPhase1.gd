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
	
func animations(_direction):
	if status == WALK:
		$AnimatedSprite.play("walk")
	elif status == IDLE :
		$AnimatedSprite.play("idle")

func _on_CollectorArea2D_area_entered(area):
	if area.is_in_group("MemoryItem") :
		area.connect("collected_animation_finished", self, "_on_finished")
		area.destroy()
		status = EVOLVE

func _on_finished():
	HUD.evolve("phase1", [
		"I...I...Remember!!!",
		"I Am a person!!!",
		"This is my Childhood!!",
		"I need to go deeper…"
	])
	yield(get_tree().create_timer(10), "timeout")
	GAME.set_phase(1)
		
func _on_TimerMidleText_timeout():
	if status == WALK || status == IDLE:
		HUD.showTextModal('midle', [
			"This place... is Familiar…",
			"I have to get out here",
			"I need to find my way…"
		])
