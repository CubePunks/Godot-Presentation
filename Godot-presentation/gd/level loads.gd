extends Node

@onready var level = load("res://tscn/level.tscn")

func _ready():
	get_parent().get_node("SubViewportContainer/SubViewport").add_child(level.instantiate()) 
