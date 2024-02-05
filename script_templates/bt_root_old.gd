extends BehaviorTree


@onready var blackboard = preload("res://data/AI/nodes/blackboard.tscn").new()
@onready var child = self.get_child(0)
@onready var actor = get_parent()

func _ready():
	blackboard.set("TIMER",null)

func _process(delta):
	blackboard.set("delta",delta)
	blackboard.set("state","running")
	if (blackboard.get("state") == "abort"):
		blackboard.set("state","running")
	child.tick(actor,blackboard)

func cancel():
	blackboard.set("state","abort")
