extends Node2D

@onready var sprite = $Sprite2D
@onready var token_empty = preload("res://entities/art/token_empty.png")
@onready var token_filled = preload("res://entities/art/token_filled.png")
@onready var token_status = null

func _ready():
	while(token_status != null):
		await get_tree().create_timer(0.01).timeout
	match token_status:
		"Filled":
			sprite.texture = token_filled
		"Empty":
			sprite.texture = token_empty


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
