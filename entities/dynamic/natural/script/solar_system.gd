extends Node2D

@onready var text = $Label
@onready var texture = $Sprite2D
@onready var select = $Sprite_Select
@onready var collision_area = $Area2D
@onready var travel_line_template : Line2D = $travel_line_template
@onready var debug_link_astar = $debug_link_astar
@onready var master_shape = $Area2D
@onready var collision_shape = $Area2D/CollisionShape2D
@onready var master_buffer = $Buffer
@onready var collision_buffer = $Buffer/CollisionShape2D

@onready var self_seed = self.get_instance_id()

var selected = false

@onready var self_position = self.position

var stellar_class = null


### System specific variables
@export var home_system = false
var revealed = true
var fleets_in_system = [
	[false,false]
]
var occupied = false

### MAPPING ###
var toBeMapped = []
var alreadyMapped = []
var linked_systems : Array = []
var astar_id : int = 0

### STELLAR SPEC ###
var habitable_zone
var planetary_system  = [null,null]
var l_star

### INIT
var readyToGo = false
@export var side : int = 0
var blackboard = null

### BT
#@export_node_path() var behavior_tree: NodePath

func _ready():
	#collision_buffer.get_shape().radius = (collision_shape.get_shape().radius) * 2
	while not readyToGo :
		await get_tree().create_timer(0.01).timeout
	self.set_meta("Type","Star_System")
	self.set_meta("Side",side)
	#behavior_tree = get_node(behavior_tree)
	var get_habitable_zone_data = GFunctions._get_star_habitable_zone(stellar_class,self_seed)
	habitable_zone = [get_habitable_zone_data[0],get_habitable_zone_data[1]]
	l_star = get_habitable_zone_data[2]
	planetary_system = [GFunctions._set_planet_system(stellar_class,self_seed),[]]
	for x in range(planetary_system[0]):
		var planet_type_dict = []
		var dist = GDatabase.db_planet_dist[int(randf_range(0,GDatabase.db_planet_dist.size()))]
		var planet_type = GDatabase.db_planet_type.keys()[int(randf_range(0,2))]
		if (dist >= habitable_zone[0] and dist <= habitable_zone[1]):
			var major_type = planet_type
			var minor_type = GDatabase.db_planet_type[planet_type]["Temperate"]
			planetary_system[1].append([major_type,minor_type,dist,[]])
			if(major_type=="Rocky"):
				GDatabase.temperatePlanets[0] += 1
			if(major_type=="Gas"):
				GDatabase.temperatePlanets[1] += 1
			if(major_type=="Ocean"):
				GDatabase.temperatePlanets[2] += 1
		elif(dist > habitable_zone[1]):
			var major_type = planet_type
			var minor_type = GDatabase.db_planet_type[planet_type]["Cold"]
			planetary_system[1].append([major_type,minor_type,dist,[]])
		elif(dist < habitable_zone[0]):
			var major_type = planet_type
			var minor_type = GDatabase.db_planet_type[planet_type]["Hot"]
			planetary_system[1].append([major_type,minor_type,dist,[]])
		
			
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


		
