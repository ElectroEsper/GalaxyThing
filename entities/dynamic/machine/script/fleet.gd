extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@onready var wings_node = $wings
@onready var moveTween = $Tween

var display_name : String = ""

#MOVEMENT RELATED#
var destination
var path = []
var path_idx = 0
var velocity = Vector2(0,0)
### SPEC ###
var speed = 100

### COMPOSITION ###
var wings = []

### AI ###
var blackboard = null
@export var side : int = 0




# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_meta("Type","Fleet")
	self.set_meta("Side",side)

#func _process(delta):
	#yield(get_tree().create_timer(0.01), "timeout")
	#




