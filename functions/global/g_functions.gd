#extends Node
extends Node2D

const ENTITIES_HEXAGON = preload("res://entities/dynamic/natural/solar_system.tscn")
const ENTITIES_TOKEN = preload("res://entities/static/token.tscn")

@onready var g_universe = get_node("/root/universe")

func _ready():
	pass
# params [center(vector2),size(center to corner),i(which of the six corners)]
func _create_hexagon_corner(center:Vector2,size:int,i:int):
	var angle_deg = 60 * i
	var angle_rad = PI / 180 * angle_deg
	return Vector2((center.x + size * cos(angle_rad)),(center.y+size * sin(angle_rad)))

func _create_hexagon_borders(center:Vector2,size:int):
	var l_corner_assembly = []
	for i in [1,2,3,4,5,6,1,2]:
		var l_corner = _create_hexagon_corner(center,size,i)
		l_corner_assembly.push_back(l_corner)
		
	return [center,size,l_corner_assembly]
	
func _add_adjacent_hexagons(reference_center:Vector2,reference_size:int,reference_hexagon):
	var dict_border_hexagon = reference_hexagon.dict_adjacent_hexagon
	var l_coord = reference_hexagon.self_coordinate
	var w = 2 * reference_size
	var h = sqrt(3) * reference_size
	var horizontal_dist = w * (0.75)
	var vertical_dist = h
	
	var l_one = "[%d, %d, %d]" % [l_coord[0]+0,l_coord[1]+1,l_coord[2]-1]
	var l_two = "[%d, %d, %d]" % [l_coord[0]+1,l_coord[1]+0,l_coord[2]-1]
	var l_three = "[%d, %d, %d]" % [l_coord[0]+1,l_coord[1]-1,l_coord[2]+0]
	var l_four = "[%d, %d, %d]" % [l_coord[0]+0,l_coord[1]-1,l_coord[2]+1]
	var l_five = "[%d, %d, %d]" % [l_coord[0]-1,l_coord[1]+0,l_coord[2]+1]
	var l_six = "[%d, %d, %d]" % [l_coord[0]-1,l_coord[1]+1,l_coord[2]+0]
	
	for a in dict_border_hexagon:
		await get_tree().create_timer(0.01).timeout
		if(not dict_border_hexagon[a][0]):
			match a:
				l_one:
					var l_center = Vector2(reference_center.x,reference_center.y+vertical_dist)
					var new_hexagon = _create_hexagon(l_center,reference_size)
					dict_border_hexagon[a] = [true,new_hexagon]
					new_hexagon.self_coordinate[0] = reference_hexagon.self_coordinate[0] + 0
					new_hexagon.self_coordinate[1] = reference_hexagon.self_coordinate[1] + 1
					new_hexagon.self_coordinate[2] = reference_hexagon.self_coordinate[2] - 1
					#GDatabase.db_star_system[[new_hexagon[0],new_hexagon[1],new_hexagon[2]]] = new_hexagon
				l_two:
					var l_center = Vector2(reference_center.x+horizontal_dist,reference_center.y+(vertical_dist/2))
					var new_hexagon = _create_hexagon(l_center,reference_size)
					dict_border_hexagon[a] = [true,new_hexagon]
					new_hexagon.self_coordinate[0] = reference_hexagon.self_coordinate[0] + 1
					new_hexagon.self_coordinate[1] = reference_hexagon.self_coordinate[1] + 0
					new_hexagon.self_coordinate[2] = reference_hexagon.self_coordinate[2] - 1
					#GDatabase.db_star_system[[new_hexagon[0],new_hexagon[1],new_hexagon[2]]] = new_hexagon
				l_three:
					var l_center = Vector2(reference_center.x+horizontal_dist,reference_center.y-(vertical_dist/2))
					var new_hexagon = _create_hexagon(l_center,reference_size)
					dict_border_hexagon[a] = [true,new_hexagon]
					new_hexagon.self_coordinate[0] = reference_hexagon.self_coordinate[0] + 1
					new_hexagon.self_coordinate[1] = reference_hexagon.self_coordinate[1] - 1
					new_hexagon.self_coordinate[2] = reference_hexagon.self_coordinate[2] + 0
					#GDatabase.db_star_system[[new_hexagon[0],new_hexagon[1],new_hexagon[2]]] = new_hexagon
				l_four:
					var l_center = Vector2(reference_center.x,reference_center.y-vertical_dist)
					var new_hexagon = _create_hexagon(l_center,reference_size)
					dict_border_hexagon[a] = [true,new_hexagon]
					new_hexagon.self_coordinate[0] = reference_hexagon.self_coordinate[0] + 0
					new_hexagon.self_coordinate[1] = reference_hexagon.self_coordinate[1] - 1
					new_hexagon.self_coordinate[2] = reference_hexagon.self_coordinate[2] + 1
					#GDatabase.db_star_system[[new_hexagon[0],new_hexagon[1],new_hexagon[2]]] = new_hexagon
				l_five:
					var l_center = Vector2(reference_center.x-horizontal_dist,reference_center.y-(vertical_dist/2))
					var new_hexagon = _create_hexagon(l_center,reference_size)
					dict_border_hexagon[a] = [true,new_hexagon]
					new_hexagon.self_coordinate[0] = reference_hexagon.self_coordinate[0] - 1
					new_hexagon.self_coordinate[1] = reference_hexagon.self_coordinate[1] - 0
					new_hexagon.self_coordinate[2] = reference_hexagon.self_coordinate[2] + 1
					#GDatabase.db_star_system[[new_hexagon[0],new_hexagon[1],new_hexagon[2]]] = new_hexagon
				l_six:
					var l_center = Vector2(reference_center.x-horizontal_dist,reference_center.y+(vertical_dist/2))
					var new_hexagon = _create_hexagon(l_center,reference_size)
					dict_border_hexagon[a] = [true,new_hexagon]
					new_hexagon.self_coordinate[0] = reference_hexagon.self_coordinate[0] - 1
					new_hexagon.self_coordinate[1] = reference_hexagon.self_coordinate[1] + 1
					new_hexagon.self_coordinate[2] = reference_hexagon.self_coordinate[2] + 0
					#GDatabase.db_star_system[[new_hexagon[0],new_hexagon[1],new_hexagon[2]]] = new_hexagon
	
func _create_hexagon(center:Vector2,size:int):
	var new_hexagon = load("res://entities/dynamic/natural/solar_system.tscn")
	var new_hexagon_1 = new_hexagon.instantiate()
	new_hexagon_1.position = center
	g_universe.add_child(new_hexagon_1)
	return new_hexagon_1
	
func _create_token(center:Vector2,parent):
	# params : 	0 - vector2
	#			1 - object
	#
	#returns :	object
	
	var new_token = load("res://entities/static/token.tscn")
	var new_token_1 = new_token.instantiate()
	new_token_1.position = center
	parent.add_child(new_token_1)
	return new_token_1

"""
func _check_adjacent(coordinate:Array,dict_adjacent:Dictionary,object):
	#params :	0 - arr[int,int,int]
	#			1 - dict
	#
	#return :	null
	
	var l_coord = coordinate
	
	var l_one = "[%d, %d, %d]" % [l_coord[0]+0,l_coord[1]+1,l_coord[2]-1]
	var l_two = "[%d, %d, %d]" % [l_coord[0]+1,l_coord[1]+0,l_coord[2]-1]
	var l_three = "[%d, %d, %d]" % [l_coord[0]+1,l_coord[1]-1,l_coord[2]+0]
	var l_four = "[%d, %d, %d]" % [l_coord[0]+0,l_coord[1]-1,l_coord[2]+1]
	var l_five = "[%d, %d, %d]" % [l_coord[0]-1,l_coord[1]+0,l_coord[2]+1]
	var l_six = "[%d, %d, %d]" % [l_coord[0]-1,l_coord[1]+1,l_coord[2]+0]
	
	for a in dict_adjacent:
		if(not dict_adjacent[a][0]):
			match a:
				l_one:
					
					var l_hexagon_exist = GDatabase.db_star_system.has([coordinate[0]+0,coordinate[1]+1,coordinate[2]-1])
					print(l_hexagon_exist)
					if(l_hexagon_exist):
						var l_hexagon = GDatabase.db_star_system[ [ coordinate[0]+0, coordinate[1]+1, coordinate[2]-1 ] ]
						dict_adjacent[a] = [true,l_hexagon]
						dict_adjacent[a][1].dict_adjacent_hexagon[str(coordinate)] = [true,object]
						if(GVariables.DEBUG):
							object.debug_link.add_point(Vector2(0,0))
							object.debug_link.add_point(l_hexagon.position-object.position)
				l_two:
					var l_hexagon_exist = GDatabase.db_star_system.has([coordinate[0]+1,coordinate[1]+0,coordinate[2]-1])
					if(l_hexagon_exist):
						var l_hexagon = GDatabase.db_star_system[[coordinate[0]+1,coordinate[1]+0,coordinate[2]-1]]
						dict_adjacent[a] = [true,l_hexagon]
						dict_adjacent[a][1].dict_adjacent_hexagon[str(coordinate)] = [true,object]
						if(GVariables.DEBUG):
							object.debug_link.add_point(Vector2(0,0))
							object.debug_link.add_point(l_hexagon.position-object.position)
				l_three:
					var l_hexagon_exist = GDatabase.db_star_system.has([coordinate[0]+1,coordinate[1]-1,coordinate[2]-0])
					if(l_hexagon_exist):
						var l_hexagon = GDatabase.db_star_system[[coordinate[0]+1,coordinate[1]-1,coordinate[2]-0]]
						dict_adjacent[a] = [true,l_hexagon]
						dict_adjacent[a][1].dict_adjacent_hexagon[str(coordinate)] = [true,object]
						if(GVariables.DEBUG):
							object.debug_link.add_point(Vector2(0,0))
							object.debug_link.add_point(l_hexagon.position-object.position)
				l_four:
					var l_hexagon_exist = GDatabase.db_star_system.has([coordinate[0]+0,coordinate[1]-1,coordinate[2]+1])
					if(l_hexagon_exist):
						var l_hexagon = GDatabase.db_star_system[[coordinate[0]+0,coordinate[1]-1,coordinate[2]+1]]
						dict_adjacent[a] = [true,l_hexagon]
						dict_adjacent[a][1].dict_adjacent_hexagon[str(coordinate)] = [true,object]
						if(GVariables.DEBUG):
							object.debug_link.add_point(Vector2(0,0))
							object.debug_link.add_point(l_hexagon.position-object.position)
				l_five:
					var l_hexagon_exist = GDatabase.db_star_system.has([coordinate[0]-1,coordinate[1]+0,coordinate[2]+1])
					if(l_hexagon_exist):
						var l_hexagon = GDatabase.db_star_system[[coordinate[0]-1,coordinate[1]+0,coordinate[2]+1]]
						dict_adjacent[a] = [true,l_hexagon]
						dict_adjacent[a][1].dict_adjacent_hexagon[str(coordinate)] = [true,object]
						if(GVariables.DEBUG):
							object.debug_link.add_point(Vector2(0,0))
							object.debug_link.add_point(l_hexagon.position-object.position)
				l_six:
					var l_hexagon_exist = GDatabase.db_star_system.has([coordinate[0]-1,coordinate[1]+1,coordinate[2]-0])
					if(l_hexagon_exist):
						var l_hexagon = GDatabase.db_star_system[[coordinate[0]-1,coordinate[1]+1,coordinate[2]-0]]
						dict_adjacent[a] = [true,l_hexagon]
						dict_adjacent[a][1].dict_adjacent_hexagon[str(coordinate)] = [true,object]
						if(GVariables.DEBUG):
							object.debug_link.add_point(Vector2(0,0))
							object.debug_link.add_point(l_hexagon.position-object.position)
"""
func _generate_star_class(ID:int): 
	#params : 	0 - int
	#
	#returns :	string
	
	var l_seed = GVariables.SEED + ID
	var l_rng = RandomNumberGenerator.new()
	l_rng.seed = l_seed
	var l_roll = l_rng.randf_range(0,100)
	if(l_roll<=0.00003):
		#print("[%s:%s:%s] Generating a CLASS O" % [OS.get_time()["hour"],OS.get_time()["minute"],OS.get_time()["second"]])
		return "classO"
	elif( (l_roll>0.00003) and (l_roll <=0.13) ):
		#print("[%s:%s:%s] Generating a CLASS B" % [OS.get_time()["hour"],OS.get_time()["minute"],OS.get_time()["second"]])
		return "classB"
	elif( (l_roll>0.13) and (l_roll <=0.6) ):
		#print("[%s:%s:%s] Generating a CLASS A" % [OS.get_time()["hour"],OS.get_time()["minute"],OS.get_time()["second"]])
		return "classA"
	elif( (l_roll>0.6) and (l_roll <=3) ):
		#print("[%s:%s:%s] Generating a CLASS F" % [OS.get_time()["hour"],OS.get_time()["minute"],OS.get_time()["second"]])
		return "classF"
	elif( (l_roll>3) and (l_roll <=7.6) ):
		#print("[%s:%s:%s] Generating a CLASS G" % [OS.get_time()["hour"],OS.get_time()["minute"],OS.get_time()["second"]])
		return "classG"
	elif( (l_roll>7.6) and (l_roll <=12.1) ):
		#print("[%s:%s:%s] Generating a CLASS K" % [OS.get_time()["hour"],OS.get_time()["minute"],OS.get_time()["second"]])
		return "classK"
	elif(l_roll>12.1):
		#print("[%s:%s:%s] Generating a CLASS M" % [OS.get_time()["hour"],OS.get_time()["minute"],OS.get_time()["second"]])
		return "classM"

func _generate_dictionnary_border(object):
	# params :	0 - aobject calling function
	#
	# returns:	null
	
	var l_coord = object.self_coordinate
	var l_dict = object.dict_adjacent_hexagon
	var l_offset_arr = GDatabase.db_hexagon_offset
	for each in l_offset_arr:
		var each_0 = each[0] + l_coord[0]
		var each_1 = each[1] + l_coord[1]
		var each_2 = each[2] + l_coord[2]
		l_dict[str([each_0,each_1,each_2])] = [false,null]
		#print(l_dict[str([each_0,each_1,each_2])])

func _a_star_get_path_dist_coord(from,to,mode:bool):
	
	#						who,dist_from_last,dist_to_goal(heuristic),last_from
	var done = false
	#var priority_queue = [ [from,0,_a_star_get_heuristic_dist_coord(from,to),null] ]_a_star_get_heuristic_dist_position
	var priority_queue = [ [from,0,_a_star_get_heuristic_dist_position(from,to),null] ]
	var tested_path = []
	var l_card
	var path_dist = 0
	
	while(not done):	#	 0	    1	     	2			3
		var frontier = [] # [who,path_dist,direct_dist,last_from]
		var tested = priority_queue[0]
		for a in tested[0].dict_adjacent_hexagon: #TEST ADJACENT TILE
			var l_object_a = tested[0].dict_adjacent_hexagon[a][1]
			if(l_object_a != null):
				if(l_object_a.revealed):
					l_card = [l_object_a,_a_star_get_direct_dist_coord(tested[0],l_object_a),_a_star_get_heuristic_dist_position(l_object_a,to),tested[0]]
					if (l_card[0]==to):
						done = true	
						priority_queue.push_front(l_card)
					else:	
						frontier.push_front(l_card)

		frontier.sort_custom(Callable(custom_sorter, "sort_ascending_for_a_star_hex"))
		tested_path.push_front(tested)
		priority_queue.remove(0)
		for b in frontier:
			priority_queue.append(b)
		priority_queue.sort_custom(Callable(custom_sorter, "sort_ascending_for_a_star_hex"))
		#

	tested_path.push_front(l_card)
	for c in tested_path:
		path_dist += c[1]
	
	
	if(mode):
		if(GVariables.DEBUG):from.debug_link_astar.clear_points()
		if(GVariables.DEBUG):for d in tested_path:
			if(GVariables.DEBUG):from.debug_link_astar.add_point(d[0].position - from.position)
			if(GVariables.DEBUG):from.debug_link_astar.used = true
		return path_dist
	if(not mode):
		return tested_path

func _a_star_get_direct_dist_coord(from,to):
	var c = _a_star_get_heuristic_dist_coord(from,to)
	return c

func _a_star_get_heuristic_dist_coord(from,goal):
	var a = from.self_coordinate
	var b = goal.self_coordinate
	return ( abs(a[0]-b[0]) + abs(a[1]-b[1]) + abs(a[2]-b[2]) )/2

func _a_star_get_heuristic_dist_position(from,goal):
	var a = from.position
	var b = goal.position
	return ( abs(a.x-b.x) + abs(a.y-b.y))/2

func _find_star(from):
	var done = false
		
	var testing_queue = [from]

	while(not done):
		for a in testing_queue: # CYCLE TESTING QUEUE

			for b in a.dict_adjacent_hexagon: #CHECK A'S ADJACENT TILE

				var l_b_object = a.dict_adjacent_hexagon[b][1] #GET B'S OBJECT

				if(l_b_object != null):
					var l_b_object_revealed = l_b_object.revealed #GET OBJECT'S STATUS
					if(l_b_object_revealed): #IF TILE IS REVEALED
						if(l_b_object.stellar_class != null):#IF WE HAVE STAR
							done = true

							return l_b_object
						else:
							if(not testing_queue.has(l_b_object)):
								testing_queue.append(l_b_object)
						pass
					pass
				pass
			testing_queue.erase(a)
		pass
	pass

func _generate_tile(tile):
	var l_closest_star = GFunctions._find_star(tile)
	#if(GVariables.DEBUG):
		#print("Closest star is a %s" % [l_closest_star.stellar_class])
	var l_closest_star_dist = _a_star_get_path_dist_coord(tile,l_closest_star,true)
	
	if (l_closest_star.stellar_class in ["classO"]):
		if(l_closest_star_dist<3):
			tile.stellar_class = null
		elif(l_closest_star_dist<4):
			var l_roll = _roll_AdB(1,20,tile)

			if(l_roll>17):
				tile.stellar_class = GFunctions._generate_star_class(tile.self_seed)
			else:
				tile.stellar_class = null	
		else:
			var l_roll = _roll_AdB(1,20,tile)

			if(l_roll>15):
				tile.stellar_class = GFunctions._generate_star_class(tile.self_seed)
			else:
				tile.stellar_class = null	
	
	elif(l_closest_star.stellar_class in ["classB"]):
		if(l_closest_star_dist<2):
			tile.stellar_class = null
		elif(l_closest_star_dist<3):
			var l_roll = _roll_AdB(1,20,tile)

			if(l_roll>17):
				tile.stellar_class = GFunctions._generate_star_class(tile.self_seed)
			else:
				tile.stellar_class = null	
		else:
			var l_roll = _roll_AdB(1,20,tile)

			if(l_roll>15):
				tile.stellar_class = GFunctions._generate_star_class(tile.self_seed)
			else:
				tile.stellar_class = null	
	
	elif (l_closest_star.stellar_class in ["classA","classF"]):
		if(l_closest_star_dist<2):
			tile.stellar_class = null
		else:
			var l_roll = _roll_AdB(1,20,tile)

			if(l_roll>17):
				tile.stellar_class = GFunctions._generate_star_class(tile.self_seed)
			else:
				tile.stellar_class = null
	
	elif (l_closest_star.stellar_class in ["classG","classK"]):
		var l_roll = _roll_AdB(1,20,tile)

		if(l_roll>17):
			tile.stellar_class = GFunctions._generate_star_class(tile.self_seed)
		else:
			tile.stellar_class = null
	
	elif (l_closest_star.stellar_class in ["classM",null]):
		var l_roll = _roll_AdB(1,20,tile)

		if(l_roll>15):
			tile.stellar_class = GFunctions._generate_star_class(tile.self_seed)
		else:
			tile.stellar_class = null
	if(tile.stellar_class == null):
		#print("[%s:%s:%s] Generated a void" % [OS.get_time()["hour"],OS.get_time()["minute"],OS.get_time()["second"]])
		tile.texture.visible = false
	else:
		tile.texture.visible = true
	tile.texture.self_modulate = GDatabase.db_stellar_class[tile.stellar_class][0]
	if(tile.stellar_class!=null):
		tile.texture.texture = load(GDatabase.db_stellar_class[tile.stellar_class][1])
	if (tile.token != null):
			tile.token.sprite.visible = false
			tile.token.queue_free()
	GFunctions._add_adjacent_hexagons(tile.self_position,tile.self_size,tile)
	tile.border_lines.visible = false

func _roll_AdB(a,b,who):
	var l_rng = RandomNumberGenerator.new()
	l_rng.seed = GVariables.SEED+a+b+who.get_instance_id()
	return l_rng.randi_range(a,b)

func _generateStar(pos:Vector2):
	var l_star = load("res://entities/dynamic/natural/solar_system.tscn")
	var l_star_1 = l_star.instantiate()
	g_universe.add_child(l_star_1)
	l_star_1.position = pos
	l_star_1.stellar_class = GFunctions._generate_star_class(l_star_1.self_seed)
	l_star_1.texture.texture = load(GDatabase.db_stellar_class[l_star_1.stellar_class][1])
	if(GVariables.DEBUG):
		GDatabase.star_catalog[l_star_1.stellar_class].append(l_star_1)
	return l_star_1

func _generateGalaxy(amount:int,arms:int,offsetMax:float,rotFactor:float,rndOffset:float):
	var size = amount * 10
	#var size = 200
	var l_count = 0
	var l_seed = amount
	var l_rng = RandomNumberGenerator.new()
	var l_dist_coef = 0.5
	l_rng.seed = l_seed
	
	
	var l_arm_separation_dist = 2 * PI / arms
	var l_arm_offset
		
	var l_distance:float
	var l_angle:float
	var starPos:Vector2
	var starSize
	
	for i in amount:
		l_rng.seed += 1
		var star = _generateStar(Vector2(0,0))
		GVariables.UNIVERSE.star_systems.append(star)
		
		GDatabase.db_star_system.append(star)
		
		var result = []
		
		var l_search = true
		print("%s/%s" % [i+1,amount])
		while(l_search):
			
			#Random distance float (0.0-1.0)
			l_distance = l_rng.randf() + l_dist_coef
			l_distance = pow(l_distance,2)
			
			#Random angle between 0 and 2*Pi
			l_angle = l_rng.randf() * 2 * PI
			l_arm_offset = l_rng.randf() * offsetMax
			l_arm_offset = l_arm_offset - offsetMax / 2
			l_arm_offset = l_arm_offset * (1/l_distance)
			
			var l_arm_offset_sqr = pow(l_arm_offset,2)
			if (l_arm_offset < 0):
				l_arm_offset_sqr = l_arm_offset_sqr * -1
			l_arm_offset = l_arm_offset_sqr
			
			var l_rotation = l_distance * rotFactor
			
			l_angle = int(l_angle/l_arm_separation_dist) * l_arm_separation_dist + l_arm_offset + l_rotation
			#print(l_angle)
			#Convert polar coordinates to 2d cartesian
			starPos.x = (cos(l_angle) * l_distance)  * (size*2)
			starPos.y = (sin(l_angle) * l_distance)  * (size*2)
			
			var l_random_offset:Vector2
			l_random_offset.x = l_rng.randf() * rndOffset
			l_random_offset.y = l_rng.randf() * rndOffset
			
			starPos.x += l_random_offset.x
			starPos.y += l_random_offset.y
			
			star.position = starPos
			
			await get_tree().create_timer(0.04).timeout
			
			result = star.master_buffer.get_overlapping_areas()
			#var self_buffer = star.master_buffer
			result.erase(star.master_shape)
			result.erase(star.master_buffer)
			if(result.size() == 0):
				l_search = false
			else:
				offsetMax += 0.0015
				#print(offsetMax)
				#l_arm_separation_dist -= 0.0015
				#l_dist_coef +=0.005
				#print(l_arm_separation_dist)
				#l_random_offset.y += 0.0015
			
		l_search = false
		star.astar_id = GVariables.UNIVERSE.star_systems.size()
		GDatabase.db_astar_id[star.astar_id] = star
		GVariables.ASTAR.add_point(star.astar_id,star.position,1)
		star.revealed = true
		star.readyToGo = true
		#return starPos
		GVariables.UNIVERSE.star_systems_pos.append(starPos)
		var g_distance = _distance(Vector2(0,0),starPos)
		if(g_distance < GVariables.MINCURRENTDISTANCE):
			GVariables.MINCURRENTDISTANCE = g_distance
		if(g_distance > GVariables.MAXCURRENTDISTANCE):
			GVariables.MAXCURRENTDISTANCE = g_distance
		
	print(GVariables.ASTAR.get_point_count())	
	for i in GVariables.UNIVERSE.star_systems:
		i.master_buffer.queue_free()
		i.master_buffer.queue_free()
		
				
	
	#GVariables.MINLANEDISTANCE = GVariables.MINCURRENTDISTANCE
	GVariables.MINLANEDISTANCE = 1
	GVariables.MAXLANEDISTANCE = GVariables.MAXCURRENTDISTANCE * 0.10
	
	GVariables.UNIVERSE.star_triangles = _delaunayLinks(GVariables.UNIVERSE.star_systems_pos)
	_drawLineTri()
	_merge_clusters()
	
	#MAP ASTAR NODES
	for j in GDatabase.db_star_system:
		for k in j.linked_systems:
			if not GVariables.ASTAR.are_points_connected(j.astar_id,k.astar_id):
				GVariables.ASTAR.connect_points(j.astar_id,k.astar_id,true)
				
	
	print("O-Class : %s" % [GDatabase.star_catalog["classO"].size()])
	print("B-Class : %s" % [GDatabase.star_catalog["classB"].size()])
	print("A-Class : %s" % [GDatabase.star_catalog["classA"].size()])
	print("F-Class : %s" % [GDatabase.star_catalog["classF"].size()])
	print("G-Class : %s" % [GDatabase.star_catalog["classG"].size()])
	print("K-Class : %s" % [GDatabase.star_catalog["classK"].size()])
	print("M-Class : %s" % [GDatabase.star_catalog["classM"].size()])
	print("Habitable Planets - Rocky : %s | Gas : %s | Ocean : %s" % [GDatabase.temperatePlanets[0],GDatabase.temperatePlanets[1],GDatabase.temperatePlanets[2]])
	
	GVariables.GAME_READY = true
	
	await get_tree().create_timer(0.5).timeout
	
	for a in GDatabase.db_star_system:
		#a.behavior_tree.start()
		#var bt = a.behavior_tree
		#bt = get_node(bt)
		#bt.is_active = true
		#bt.start()
		pass


func _get_star_habitable_zone (stellar_class : String,star_seed):
	#Starting with habitable zone
	var l_rng = RandomNumberGenerator.new()
	l_rng.seed = star_seed
	
	var mv_max = GDatabase.db_stellar_class_specs[stellar_class]["Habitable Zone"]["MvMax"]
	var mv_min = GDatabase.db_stellar_class_specs[stellar_class]["Habitable Zone"]["MvMin"]
	var mv_diff = mv_max - mv_min
	
	var bc_max = GDatabase.db_stellar_class_specs[stellar_class]["Habitable Zone"]["BCMax"]
	var bc_min = GDatabase.db_stellar_class_specs[stellar_class]["Habitable Zone"]["BCMin"]
	var bc_diff = bc_max - bc_min
	
	var mv = l_rng.randf_range(mv_max,mv_min)
	var bc_raw = ((mv - mv_min)/mv_diff)*bc_diff
	var bc = bc_raw+bc_min
	
	var m_bol = mv + bc
	var l_star = pow(10,((m_bol-4.72)/-2.5))
	var ri = sqrt((l_star/1.1))
	var ro = sqrt((l_star/0.53))
	
	return [ri,ro,l_star]
	
func _set_planet_system(stellar_class : String,star_seed):
	var l_rng = RandomNumberGenerator.new()
	l_rng.seed = star_seed
	
	var planet_count = l_rng.randi_range(GDatabase.db_stellar_class_specs[stellar_class]["Planet Potential"]["Count"][0],GDatabase.db_stellar_class_specs[stellar_class]["Planet Potential"]["Count"][1])
	
	return planet_count
	
func _delaunayLinks (arr:Array):
	var triangles = Geometry2D.triangulate_delaunay(arr)
	return triangles

func _drawLineTri():
	var idx = 0
	while idx < GVariables.UNIVERSE.star_triangles.size():
		
		var s1 = GVariables.UNIVERSE.star_systems[GVariables.UNIVERSE.star_triangles[idx+0]]
		var s2 = GVariables.UNIVERSE.star_systems[GVariables.UNIVERSE.star_triangles[idx+1]]
		var s3 = GVariables.UNIVERSE.star_systems[GVariables.UNIVERSE.star_triangles[idx+2]]
		
		var p1 = GVariables.UNIVERSE.star_systems_pos[GVariables.UNIVERSE.star_triangles[idx+0]]
		var p2 = GVariables.UNIVERSE.star_systems_pos[GVariables.UNIVERSE.star_triangles[idx+1]]
		var p3 = GVariables.UNIVERSE.star_systems_pos[GVariables.UNIVERSE.star_triangles[idx+2]]
		
		var p1V = _findVectorComponent(p3,p1,1)
		var p2V = _findVectorComponent(p1,p2,1)
		var p3V = _findVectorComponent(p2,p3,1)
		
		var distance1t2 = _distance(p1,p2)
		var distance2t3 = _distance(p2,p3)
		var distance3t1 = _distance(p3,p1)
		
		if not (s1.alreadyMapped.has(s2)):
			if(distance1t2 <= GVariables.MAXLANEDISTANCE and distance1t2 >= GVariables.MINLANEDISTANCE):
				if(_cleanLine(p1,p2)):
					#var p1V = _findVectorComponent(p3,p1,1)
					var new_line = s1.travel_line_template.duplicate()
					s1.add_child(new_line)
					new_line.add_point(Vector2(0,0).move_toward(p2V,25))
					new_line.add_point(p2V.move_toward(Vector2(0,0),25))
					
					s1.alreadyMapped.append(s2)
					s2.alreadyMapped.append(s1)
					
					s1.linked_systems.append(s2)
					s2.linked_systems.append(s1)
					
					#GVariables.ASTAR.connect_points(s1.astar_id,s2.astar_id,true)
					
					var arr = [p1,p2,s1,s2]
					GVariables.DELAUNEY_LINKS.append(arr)
					
		if not (s2.alreadyMapped.has(s3)):
			if(distance2t3 <= GVariables.MAXLANEDISTANCE and distance1t2 >= GVariables.MINLANEDISTANCE):
				if(_cleanLine(p2,p3)):
					var new_line = s1.travel_line_template.duplicate()
					s2.add_child(new_line)
					new_line.add_point(Vector2(0,0).move_toward(p3V,25))
					new_line.add_point(p3V.move_toward(Vector2(0,0),25))
					
					s2.alreadyMapped.append(s3)
					s3.alreadyMapped.append(s2)
					
					s2.linked_systems.append(s3)
					s3.linked_systems.append(s2)
					
					#GVariables.ASTAR.connect_points(s2.astar_id,s3.astar_id,true)
					
					var arr = [p2,p3,s2,s3]
					GVariables.DELAUNEY_LINKS.append(arr)
					
		if not (s3.alreadyMapped.has(s1)):
			if(distance3t1 <= GVariables.MAXLANEDISTANCE and distance3t1 >= GVariables.MINLANEDISTANCE):
				if(_cleanLine(p3,p1)):
					var new_line = s1.travel_line_template.duplicate()
					s3.add_child(new_line)
					new_line.add_point(Vector2(0,0).move_toward(p1V,25))
					new_line.add_point(p1V.move_toward(Vector2(0,0),25))
					
					s3.alreadyMapped.append(s1)
					s1.alreadyMapped.append(s3)
					
					s3.linked_systems.append(s1)
					s1.linked_systems.append(s3)
					
					#GVariables.ASTAR.connect_points(s3.astar_id,s1.astar_id,true)
					
					var arr = [p3,p1,s3,s1]
					GVariables.DELAUNEY_LINKS.append(arr)
		
		idx += 3

func _cleanLine(source,target):
	
	var midpoint = [(source.x+target.x)/2,(source.y+target.y)/2]
	#var r = pow((source.distance_to(target)/2.01),1)
	var r = _hypot(source.x-target.x,source.y-target.y)/2
	var inside = []
	for p in GVariables.UNIVERSE.star_systems_pos:
		var math = _hypot(midpoint[0]-p.x,midpoint[1]-p.y)
		if(math < r):
			inside.append(p)
	
	if(inside.size() == 0):
		return true
	elif(inside.size()>0):
		return false
		
func _findVectorComponent (from,to,multFactor):
	var p = from
	var p1 = p.x
	var p2 = p.y
		
	var q = to
	var q1 = q.x
	var q2 = q.y
		
	var v = Vector2( (q1-p1)*multFactor,(q2-p2)*multFactor)
	return v

func _distance(a,b):
	var distance = sqrt( pow(b.x-a.x,2)+pow(b.y-a.y,2))
	return distance

func _hypot(x,y):
	var h = sqrt((x*x)+(y*y))
	return h	

func _merge_clusters():
	var cluster_arr : Array = []
	var current_cluster : Array = []
	var counted_stars : int = 0
	
	var stars_all : Array = GVariables.UNIVERSE.star_systems
	var stars_testing_pool = stars_all
	var start_point = stars_all[0]
	
	var stars_to_test : Array = [start_point]
	var stars_tested : Array = []
	
	while stars_testing_pool.size() > 0:
		if stars_to_test.size() != 0 : #If there are stars to test
			if(stars_to_test[0].alreadyMapped.size() != 0):#If tested star has linked elements
				for i in stars_to_test[0].alreadyMapped: #For each linked stars
					if not (i in stars_tested): #If not already tested
						if not (i in stars_to_test): #If also not in start to be tested
							stars_to_test.append(i) #Add to list to test
			stars_tested.append(stars_to_test[0]) #Add current star as TESTED
			current_cluster.append(stars_to_test[0])#Add to current cluster
			stars_testing_pool.erase(stars_to_test[0])#Remove TESTED star from stars testing pool
			stars_to_test. remove_at(0) #Remove TESTED star from list to test
		else: #If current cluster was exhausted
			
			var total_pos : Vector2 = Vector2(0,0)
			for star in current_cluster: #Find average distance of current cluster from 0,0
				total_pos.x += star.position.x
				total_pos.y += star.position.y
			var avg_pos = Vector2(total_pos.x/current_cluster.size(),total_pos.y/current_cluster.size())
			cluster_arr.append([avg_pos,current_cluster]) #Add exahusted cluster to list of clusters
			current_cluster = [] #Wipe current cluster
			
			if(stars_testing_pool.size()>0):#If there is still stars to test in pool
				stars_to_test.append(stars_testing_pool[int(floor(randf_range(0,stars_testing_pool.size())))])#Select a new starter star
	
	var total_pos : Vector2 = Vector2(0,0)
	for star in current_cluster: #Find average distance of current cluster from 0,0
		total_pos.x += star.position.x
		total_pos.y += star.position.y
	var avg_pos = Vector2(total_pos.x/current_cluster.size(),total_pos.y/current_cluster.size())
	cluster_arr.append([avg_pos,current_cluster]) #Add exahusted cluster to list of clusters
	current_cluster = [] #Wipe current cluster
		
	#_draw_clusters(cluster_arr)
	
	#yield(get_tree().create_timer(0.05), "timeout")
		
	while cluster_arr.size()>1:

		var cluster_list_to_test = cluster_arr
		var source_cluster = cluster_list_to_test[0]
		
		var closest_cluster = [9999999,null]
		
		for index in cluster_list_to_test.size():
			var target_cluster_pos = cluster_list_to_test[index][0]
			var target_cluster_elements = cluster_list_to_test[index][1]
			
			var dist = _distance(source_cluster[0],target_cluster_pos)
			
			if not (dist == 0):
				if(dist<closest_cluster[0]):
					closest_cluster = [dist,index]
		
		#Find closest pair of stars between clusters
		var closest_star = [9999999,null,null]
		for source_star in source_cluster[1]:
			for target_star in cluster_list_to_test[closest_cluster[1]][1]:
				var dist = _distance(source_star.position,target_star.position)
				if not (dist == 0):
					if(dist<closest_star[0]):
						closest_star = [dist,source_star,target_star]
		
		#Create a filler line
		var abV = _findVectorComponent(closest_star[1].position,closest_star[2].position,1)
		var new_line_2 = closest_star[1].travel_line_template.duplicate()
		closest_star[1].add_child(new_line_2)
		new_line_2.add_point(Vector2(0,0).move_toward(abV,25))
		new_line_2.add_point(abV.move_toward(Vector2(0,0),25))
		
		#Add to respective linked array
		closest_star[1].linked_systems.append(closest_star[2])
		closest_star[2].linked_systems.append(closest_star[1])
		
		#Clean up arrays
		for each in cluster_arr[closest_cluster[1]][1]:
			source_cluster[1].append(each)
		cluster_arr.erase(cluster_arr[closest_cluster[1]])
		
		var total_pos_2 : Vector2 = Vector2(0,0)
		for star in source_cluster[1]: #Find average distance of current cluster from 0,0
			total_pos_2.x += star.position.x
			total_pos_2.y += star.position.y
		source_cluster[0] = Vector2(total_pos_2.x/source_cluster[1].size(),total_pos_2.y/source_cluster[1].size())

func _draw_clusters(cluster_list : Array):
	for cluster in cluster_list:
		var color = Color(randf(),randf(),randf())
		for star in cluster[1]:
			var halo = Sprite2D.new()
			halo.texture = load("res://entities/dynamic/natural/art/star_select.png")
			halo.scale.x = 0.2
			halo.scale.y = 0.2
			halo.modulate = color
			star.add_child(halo)


##################################### FLEET RELATED #########################################

func _setup_wing(fleet,type):
	
	var wing = load("res://entities/dynamic/machine/wing.tscn")
	wing = wing.instantiate()
	fleet.wings_node.add_child(wing)
	wing.w_name = ""
	wing.w_type = type
	wing.w_hp = RosterUnits.space_ship[type]["HP"]
	wing.w_trait = RosterUnits.space_ship[type]["TRAIT"]
	wing.w_weapon = RosterUnits.space_ship[type]["WEP"]
	wing.w_armor = RosterUnits.space_ship[type]["ARM"]
	wing.w_speed = RosterUnits.space_ship[type]["SPD"]
	
	
	"""
	var w_name : String
	var w_type : String
	var w_hp : int
	var w_trait : String
	var w_weapon : String
	var w_armor : String
	"""
	
	"""
	var space_ship = {
	"Destroyer" : {
		"ABRE" : "DD",
		"HP" : 25,
		"SPD" : 50,
		"WEP" : "Light3D",
		"ARM" : "Light3D",
		"B-TIME" : 10
	}
}
	"""

#### MISSIONS ####
func _mission_idle(fleet):
	fleet.current_mission = "IDLE"
	
	return true


func _mission_moveTo(fleet,destination,_location):
	
	fleet = _location.fleets_in_system[0]
	var isDocked = fleet[0] #[bool,location(if true)]
	var location = _location
	var isDeployed = fleet[1]
	
	"""
	var isDocked = fleet.isDocked[0] #[bool,location(if true)]
	var location = fleet.location
	var isDeployed = fleet.isDeployed
	"""
	#isDeployed = _action_spawn(fleet,fleet.location)
	isDeployed = _action_spawn(fleet,_location)
	
	while not isDeployed[0]:
		await get_tree().create_timer(0.01).timeout
	var path = _action_move(fleet,location,destination)	
	var path_pos = []
	for a in path[1]:
		path_pos.append(GVariables.ASTAR.get_point_position(a))
	isDeployed[1].path = path_pos
	isDeployed[1].current_mission = "MOVE"
	isDeployed[1].destination = destination
	
	return true

##################
#### ACTIONS #####
func _action_spawn(fleet,location):
	var new_fleet = load("res://entities/dynamic/machine/fleet.tscn")
	new_fleet = new_fleet.instantiate()
	new_fleet.position = location.position
	GVariables.ALL_FLEETS.add_child(new_fleet)
	
	return [true,new_fleet]
	
func _action_move(fleet,source,destination):
	return _find_path_location(source,destination)
	
	#if(GVariables.DEBUG):
	#	GVariables.UNIVERSE.a_star_debug.visible = true
	#	for p in path[0]:
	#		GVariables.UNIVERSE.a_star_debug.add_point(p.position)
	#	yield(get_tree().create_timer(1), "timeout")
	#	GVariables.UNIVERSE.a_star_debug.clear_points()
	#
	#return path[1]
	
	
func _find_path_vector2(source,destination):
	var v2_path = GVariables.ASTAR.get_point_path(source.astar_id,destination.astar_id)
	#print(source.astar_id)
	#print(destination.astar_id)
	#var location_path = []
	
	#for each in id_path:
	#	var location = GDatabase.db_astar_id[each]
	#	location_path.append(location)
	
	return v2_path

func _find_path_location(source,destination):
	var id_path = GVariables.ASTAR.get_id_path(source[1],destination[1])
	#print(source[1])
	#print(destination[1])
	var location_path = []
	
	for each in id_path:
		var location = GDatabase.db_astar_id[each]
		location_path.append(location)
	
	return [location_path,id_path]
	
	
	
##################
###### MISC ######


#################

class custom_sorter:
	static func sort_ascending_for_a_star_hex(a,b):
		if (a[1]+a[2]) < (b[1]+b[2]):
			return true
		elif(a[1]+a[2]) == (b[1]+b[2]):
			if(a[1]<b[1]):
				return true
			elif(a[1]==b[1]):
				if(a[2]<b[2]):
					return true
				elif(a[2]==b[2]):
					if(a[0].get_instance_id()<b[0].get_instance_id()):
						return true
		return false
	static func sort_ascending_for_a_star(a,b):
		if (a[1]<b[1]):
			return true
		else:
			return false
	
	
