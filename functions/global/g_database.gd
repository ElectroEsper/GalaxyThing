extends Node



var db_star_system = []

var db_stellar_class = {
	"classO" : [Color(0.616,0.706,1),"res://entities/dynamic/natural/art/star_o.png"]
	,"classB" : [Color(0.667,0.749,1),"res://entities/dynamic/natural/art/star_b.png"]
	,"classA" : [Color(0.957,0.969,1),"res://entities/dynamic/natural/art/star_a.png"]
	,"classF" : [Color(0.961,0.961,0.898),"res://entities/dynamic/natural/art/star_f.png"]
	,"classG" : [Color(0.925,0.925,0.737),"res://entities/dynamic/natural/art/star_g.png"]
	,"classK" : [Color(0.941,0.753,0.569),"res://entities/dynamic/natural/art/star_k.png"]
	,"classM" : [Color(0.929,0.447,0.447),"res://entities/dynamic/natural/art/star_m.png"]
	,null : [Color(0,0,0),null]
	}

var db_hexagon_offset = [
	[0,1,-1] #1
	,[1,0,-1] #2
	,[1,-1,0] #3
	,[0,-1,1] #4
	,[-1,0,1] #5
	,[-1,1,0] #6
	]

var db_astar_id = {
	}
	
var db_stellar_class_specs = {
	"classO" : {
		"Habitable Zone":{
			"MvMax":-10,
			"MvMin":-2.3,
			"BCMax":-4.0,
			"BCMin":-2.8
		},
		"Planet Potential":{
			"Count" : [0,0]
		},
		"Misc":{
			"Lstar Min":8472.274,
			"Lstar Diff":30752495.9,
			"Star Mass Min":16,
			"Star Max Max":60
		}
	},
	"classB" : {
		"Habitable Zone":{
			"MvMax":-2.3,
			"MvMin":1,
			"BCMax":-2.8,
			"BCMin":-1.5
		},
		"Planet Potential":{
			"Count" : [0,4]
		},
		"Misc":{
			"Lstar Min":122.461,
			"Lstar Diff":8349.812,
			"Star Mass Min":2.1,
			"Star Max Max":16
		}
	},
	"classA" : {
		"Habitable Zone":{
			"MvMax":1,
			"MvMin":2,
			"BCMax":-0.4,
			"BCMin":-0.12
		},
		"Planet Potential":{
			"Count" : [0,5]
		},
		"Misc":{
			"Lstar Min":13.677,
			"Lstar Diff":30.785,
			"Star Mass Min":1.4,
			"Star Max Max":2.1
		}
	},
	"classF" : {
		"Habitable Zone":{
			"MvMax":2,
			"MvMin":5,
			"BCMax":-0.06,
			"BCMin":0
		},
		"Planet Potential":{
			"Count" : [0,6]
		},
		"Misc":{
			"Lstar Min":0.773,
			"Lstar Diff":12.169,
			"Star Mass Min":1.04,
			"Star Max Max":1.4
		}
	},
	"classG" : {
		"Habitable Zone":{
			"MvMax":5,
			"MvMin":7,
			"BCMax":-0.03,
			"BCMin":-0.07
		},
		"Planet Potential":{
			"Count" : [0,7]
		},
		"Misc":{
			"Lstar Min":0.131,
			"Lstar Diff":0.663,
			"Star Mass Min":0.8,
			"Star Max Max":1.04
		}
	},
	"classK" : {
		"Habitable Zone":{
			"MvMax":7,
			"MvMin":11,
			"BCMax":-0.2,
			"BCMin":-0.6
		},
		"Planet Potential":{
			"Count" : [0,8]
		},
		"Misc":{
			"Lstar Min":0.005,
			"Lstar Diff":0.141,
			"Star Mass Min":0.45,
			"Star Max Max":0.8
		}
	},
	"classM" : {
		"Habitable Zone":{
			"MvMax":11,
			"MvMin":16,
			"BCMax":-1.2,
			"BCMin":-2.3
		},
		"Planet Potential":{
			"Count" : [0,6]
		},
		"Misc":{
			"Lstar Min":0.0003,
			"Lstar Diff":0.009,
			"Star Mass Min":0.08,
			"Star Max Max":0.45
		}
	}
}

var db_planet_type = {
	"Rocky": {
		"Cold":	"Barren World",
		"Temperate":"Temperate World",
		"Hot":	"Scorched World"
	},
	"Gas":{
		"Cold":	"Cold Gaz Giant",
		"Temperate":"Gaz Giant",
		"Hot":	"Hot Gaz Giant"
	},
	"Ocean":{
		"Cold":	"Frozen World",
		"Temperate": "Ocean World",
		"Hot":	"Melted World"
	}
}

var db_planet_dist = []

### STATISTICS ###
var star_catalog = {
	"classO" : [],
	"classB" : [],
	"classA" : [],
	"classF" : [],
	"classK" : [],
	"classG" : [],
	"classM" : []
	}
var temperatePlanets = [0,0,0]




# Called when the node enters the scene tree for the first time.
func _ready():
	var file = FileAccess.open("res://data/starDistance_db.txt",FileAccess.READ)
	#file.open("res://data/starDistance_db.txt",file.READ)
	while not file.eof_reached():
		db_planet_dist.append(float(file.get_line()))
	file.close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
