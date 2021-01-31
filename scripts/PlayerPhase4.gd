extends "res://scripts/PlayerBase.gd" 

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
