extends Node2D



func _on_ButtonEvent_is_off_pressed():
	$AnimationPlayer.play("off")
	yield($AnimationPlayer,"animation_finished")
	queue_free()
