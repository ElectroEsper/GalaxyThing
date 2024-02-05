extends Camera2D

var MOVE_SPEED = 500
var MOVE_SPEED_CONST = MOVE_SPEED
var MOVE_SPEED_FAST = MOVE_SPEED * 3
var MAX_ZOOM = 0.5
var MIN_ZOOM = 10


var CURRENT_ZOOM_X = 1
var CURRENT_ZOOM_Y = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	GVariables.CAMERA = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_shift"):
		MOVE_SPEED = MOVE_SPEED_FAST
	if Input.is_action_just_released("ui_shift"):
		MOVE_SPEED = MOVE_SPEED_CONST
	# 4 MAIN DIRECTION (X/Y AXIS)
	if Input.is_action_pressed("ui_left"):
		global_position += Vector2.LEFT * delta * MOVE_SPEED
	if Input.is_action_pressed("ui_right"):
		global_position += Vector2.RIGHT * delta * MOVE_SPEED
	if Input.is_action_pressed("ui_up"):
		global_position += Vector2.UP * delta * MOVE_SPEED
	if Input.is_action_pressed("ui_down"):
		global_position += Vector2.DOWN * delta * MOVE_SPEED
	
	"""
	#DIAGONALS
	#DOWN-LEFT / DOWN-RIGHT
	elif (Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_left")):
		global_position += Vector2(-1,1) * delta * MOVE_SPEED
	elif (Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_right")):
		global_position += Vector2(1,1) * delta * MOVE_SPEED	
		
	#UP-LEFT / UP-RIGHT
	"""
	#ZOOMS	
	if Input.is_action_just_released("ui_zoom_in"):
		CURRENT_ZOOM_X += -0.25*delta*MOVE_SPEED
		CURRENT_ZOOM_X = clamp(CURRENT_ZOOM_X,MAX_ZOOM,MIN_ZOOM)
		CURRENT_ZOOM_Y += -0.25*delta*MOVE_SPEED
		CURRENT_ZOOM_Y = clamp(CURRENT_ZOOM_Y,MAX_ZOOM,MIN_ZOOM)
		self.zoom = Vector2(CURRENT_ZOOM_X,CURRENT_ZOOM_Y)
	if Input.is_action_just_released("ui_zoom_out"):
		CURRENT_ZOOM_X += 0.25*delta*MOVE_SPEED
		CURRENT_ZOOM_X = clamp(CURRENT_ZOOM_X,MAX_ZOOM,MIN_ZOOM)
		CURRENT_ZOOM_Y += 0.25*delta*MOVE_SPEED
		CURRENT_ZOOM_Y = clamp(CURRENT_ZOOM_Y,MAX_ZOOM,MIN_ZOOM)
		self.zoom = Vector2(CURRENT_ZOOM_X,CURRENT_ZOOM_Y)
