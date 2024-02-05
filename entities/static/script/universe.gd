extends Node2D

@onready var main_camera = $camera
@onready var a_star_debug = $a_star_debug
@onready var mouse = $mouse_pointer
@onready var all_fleets = $ALL_FLEETS

#onready var debug_button = $Control/MarginContainer/VBoxContainer/Button

@onready var mainBackground = $ParallaxBackground/Far2/Sprite2D

@onready var interface = $camera/CanvasLayer/Interface
@onready var right_menu = $camera/CanvasLayer/Interface/Panel/Tree




var debug_line_start = null
var debug_line_end = null
var debug_point_array = []

var star_systems : Array = []
var star_systems_pos : Array = []
var star_triangles : Array = []
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@export var star_amount : int = 10
@export var galaxy_arms : int = 5
@export var rotation_fact : float = 0.75

#### ASTAR ####



# Called when the node enters the scene tree for the first time.
func _ready():
	
	GVariables.UNIVERSE = self
	GVariables.ALL_FLEETS = self.all_fleets

	#size:int,amount:int,arms:int,offsetMax:float,rotFactor:float,rndOffset:float
	GFunctions._generateGalaxy(star_amount,galaxy_arms,rotation_fact,0.25,0.05)
	GVariables.CAMERA.MIN_ZOOM = star_amount/10
	mainBackground.scale.x = star_amount/25
	mainBackground.scale.y = star_amount/25
	#GVariables.ASTAR.reserve_space()
	
	
func _draw():
	
	#Draw rims
	draw_circle_arc(Vector2(0,0),(star_amount * 10)*1.250,0,360,Color(255,255,255,0.25))
	draw_circle_arc(Vector2(0,0),(star_amount * 10)*2.500,0,360,Color(255,255,255,0.25))
	draw_circle_arc(Vector2(0,0),(star_amount * 10)*4,0,360,Color(255,255,255,0.25))
	
	#Draw quandrant lines
	draw_line(Vector2(0,0), Vector2(0,(star_amount * 10)*5), Color(255,255,255,0.25), 1)#TO NORTH
	draw_line(Vector2(0,0), Vector2(0,(star_amount * 10)*-5), Color(255,255,255,0.25), 1)#TO SOUTH
	draw_line(Vector2(0,0), Vector2((star_amount * 10)*5,0), Color(255,255,255,0.25), 1)#TO EAST
	draw_line(Vector2(0,0), Vector2((star_amount * 10)*-5,0), Color(255,255,255,0.25), 1)#TO WEST
	
	#Add rim text
	
func draw_string_in_angle(string : String,font,angle:int):
	var x = (angle)/ string.length()
	for i in range(0,string.length()):
		
		draw_char(font, Vector2(0,-30), string[string.length()-i-1],10,Color(255,255,255,0.25))

func draw_circle_arc(center,radius,angleFrom,angleTo,color):
	var nbPoints = radius
	var pointsArc = PackedVector2Array()
	
	for i in range(nbPoints+1):
		var anglePoint = angleFrom + i*(angleTo-angleFrom)/nbPoints - 90
		var point = center + Vector2(cos(deg_to_rad(anglePoint)), sin(deg_to_rad(anglePoint)))*radius
		
		pointsArc.push_back(point)
		
	for indexPoint in range(nbPoints):
		draw_line(pointsArc[indexPoint], pointsArc[indexPoint+1], color, 1)
		

func _input(event):
	
	#LEFT CLICK
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var space_state = get_world_2d().direct_space_state
		var mouse_pointer = get_global_mouse_position()
		var result = space_state.intersect_point(mouse_pointer,1)
		var target
		var selected = GVariables.SELECTED_ENTITY
		if result:
			target = result[0]["collider"].get_parent()
			#print(result[0]["collider"].get_parent().get_name())
			if(target == selected):
				pass
			else :
				GVariables.SELECTED_ENTITY = target
			"""	
			elif (target.get_meta("Type")=="Star_System"):
				target.selected = true
				target.select.visible = true
				if(selected != null and selected.get_meta("Type")=="Star_System"):
					selected.selected = false
					selected.select.visible = false
				selected = target
			elif (target.get_meta("Type")=="Fleet"):
				if(selected.get_meta("Type")=="Star_System"):
					selected.selected = false
					selected.select.visible = false
				GVariables.SELECTED_ENTITY = target
			"""
			
			#print(GVariables.SELECTED_ENTITY)
		elif selected != null:
			if(selected.get_meta("Type")=="Star_System"):
				selected.select.visible = false
				selected.selected = false
			GVariables.SELECTED_ENTITY = null
		
	
	# RIGHT CLICK
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		var space_state = get_world_2d().direct_space_state
		var mouse_pointer = get_global_mouse_position()
		var result = space_state.intersect_point(mouse_pointer,10)
		if result != []:
			var target = result[0]["collider"].get_parent()
			#print(target)
			if(GVariables.SELECTED_ENTITY != null):
				if(target.get_meta("Type")=="Star_System"):
					if(GVariables.SELECTED_ENTITY.get_meta("Type")=="Fleet"):
						#GFunctions._mission_moveTo(GVariables.SELECTED_ENTITY,target,GVariables.SELECTED_ENTITY)
						GVariables.SELECTED_ENTITY.blackboard.set("DESTINATION",[target,target.astar_id])
						GVariables.SELECTED_ENTITY.blackboard.set("STATUS","MOVE")
						pass
	
	# CTRL + F
	#if event is InputEventWithModifiers and event.pressed and event.scancode == KEY_CONTROL:

func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	var mouse_pointer = get_global_mouse_position()
	if(GVariables.SELECTED_ENTITY != null):
		if(GVariables.SELECTED_ENTITY.get_meta("Type")=="Star_System"):
			if(GVariables.SELECTED_ENTITY.blackboard.get("ALLIED FLEETS").size()>0):
				var root = right_menu.create_item()
				right_menu.set_hide_root(true)
				var fleet = right_menu.create_item(root)
				fleet.set_text(0,GVariables.SELECTED_ENTITY.blackboard.get("ALLIED FLEETS")[0])
	
	
