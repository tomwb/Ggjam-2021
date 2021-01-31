extends Node2D
var chain_link = preload("res://scennes/ChainLink.tscn")
export var speed = 100
var radius = 90
export var chain_link_count = 4
var angle = 0

func _ready():
	pass



func _process(delta):

	radius = 22.5 * chain_link_count
	while $Chain/ChainLinks.get_child_count() <= chain_link_count:
		$Chain/ChainLinks.add_child(chain_link.instance())
	angle += speed * delta
	$Mass.position = Vector2(sin(deg2rad(angle)),cos(deg2rad(angle))) * radius
		
	var radius_chain = 0	
	for chain_link in $Chain/ChainLinks.get_children():
		chain_link.position = Vector2( sin(deg2rad(angle)), cos(deg2rad(angle))) * (radius / $Chain/ChainLinks.get_child_count()) * radius_chain
		radius_chain += 1

	
	
