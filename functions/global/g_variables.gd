extends Node

var SEED = 0
var DEBUG = true
var UNIVERSE = null
var ALL_FLEETS = null
var CAMERA = null

var GAME_READY = false

var SELECTED_UNITS = []
var SELECTED_PLANET = null
var SELECTED_ENTITY = null

## GALAXY MAPPING
var MINCURRENTDISTANCE = 999999
var MAXCURRENTDISTANCE = 0
var MINLANEDISTANCE = 0
var MAXLANEDISTANCE = 0
var DELAUNEY_LINKS : Array = []
var ASTAR = AStar2D.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
