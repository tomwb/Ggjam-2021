extends Node2D

func _ready():
	$Animation/AnimationPlayer.play("TextToTheEnd")



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "TextToTheEnd":
		$Animation/AnimationPlayer.play("TheEnd")
	elif anim_name == "TheEnd":
		$Animation/AnimationPlayer.play("Credits")
