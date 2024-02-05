extends Line2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var point_cloud = GFunctions._create_hexagon_borders(Vector2(0,0),100)
	for a in point_cloud[2]:
		add_point(a)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
