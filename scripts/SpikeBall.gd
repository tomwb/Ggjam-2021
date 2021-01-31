tool
extends Node2D

var chain_link = preload("res://scennes/ChainLink.tscn")
export var speed = 100
var radius = 90
export var chain_link_count = 4 setget set_chain_link_count
var angle = 0
export(int, "right", "left") var direction = 0

func _ready():
	pass
	
func _draw():
	if Engine.editor_hint:
		create_chain(0)

func _process(delta):
	angle += speed * delta
	create_chain(angle)

func create_chain(angle):
	radius = 22.5 * chain_link_count
	
	if (direction == 0):
		angle = angle * -1
	
	if is_inside_tree() && $Chain/ChainLinks :
		while $Chain/ChainLinks.get_child_count() <= chain_link_count:
			$Chain/ChainLinks.add_child(chain_link.instance())
			
		$Mass.position = Vector2(sin(deg2rad(angle)),cos(deg2rad(angle))) * radius
			
		var radius_chain = 0	
		for chain_link in $Chain/ChainLinks.get_children():
			chain_link.position = Vector2( sin(deg2rad(angle)), cos(deg2rad(angle))) * (radius / $Chain/ChainLinks.get_child_count()) * radius_chain
			radius_chain += 1
		
func set_chain_link_count(value):
	chain_link_count = value
	if is_inside_tree() && $Chain/ChainLinks:
		for chain_link in $Chain/ChainLinks.get_children():
			chain_link.queue_free()
	
