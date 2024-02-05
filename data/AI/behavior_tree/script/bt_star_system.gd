extends BehaviorTree


#onready var blackboard = $blackboard
@onready var child = $selector
@onready var actor = get_parent()

func _ready():
	actor.blackboard = blackboard
	blackboard.set("TIMER",null)
	blackboard.set("ALLIED FLEETS",[])
	blackboard.set("HOSTILE FLEETS",[])
	blackboard.set("UNSORTED FLEETS",[])
	blackboard.set("LEAVING FLEETS",[])
	blackboard.set("CONTACT REPORT",FAILED)
	blackboard.set("SIDE",actor.side)
	blackboard.set("state","hold")

func _process(delta):
	
	blackboard.set("delta",delta)
	if GVariables.GAME_READY :
		blackboard.set("state","running")
	if (blackboard.get("state") == "abort"):
		blackboard.set("state","running")
	if (blackboard.get("state") == "running"):
		child.tick(actor,blackboard)

func cancel():
	blackboard.set("state","abort")
