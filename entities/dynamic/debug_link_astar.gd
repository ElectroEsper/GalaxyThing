extends Line2D


var used = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	await get_tree().create_timer(1).timeout
	self.clear_points()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(used):
		await get_tree().create_timer(0.5).timeout
		self.clear_points()
