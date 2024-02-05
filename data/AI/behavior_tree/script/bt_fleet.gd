extends BehaviorTree


@onready var blackboard = $blackboard
@onready var child = self.get_child(0)
@onready var actor = get_parent()
@onready var clock = $Timer


func _ready():
	actor.blackboard = blackboard
	blackboard.set("CLOCK",clock)
	blackboard.set("STATUS", "IDLE")
	blackboard.set("TIMER",null)
	
	## MOVE RELATED
	blackboard.set("DESTINATION", null)
	blackboard.set("LOCATION",null)
	
	blackboard.set("PATH",null)
	blackboard.set("PATH IDX",null)
	blackboard.set("PATH NXT WP",null)
	
	## COMBAT RELATED
	blackboard.set("CONTACT",null)
	
	## SPEC RELATED
	blackboard.set("WINGS",[])
	blackboard.set("SPEED",null)
	var atk_dice = {
		"STRIKE" : 0,
		"LIGHT" : 0,
		"MEDIUM" : 0,
		"HEAVY" : 0,
		"SUPER" : 0
	}
	var def_dice = {
		"FLAK" : 0,
		"LIGHT" : 0,
		"MEDIUM" : 0,
		"HEAVY" : 0,
		"SUPER" : 0
	}
	blackboard.set("ATK DICE",atk_dice)
	blackboard.set("DEF DICE",def_dice)
	
	## MISC
	blackboard.set("SIDE",actor.get_meta("Side"))

func _process(delta):
	blackboard.set("delta",delta)
	blackboard.set("state","running")
	if (blackboard.get("state") == "abort"):
		blackboard.set("state","running")
	child.tick(actor,blackboard)


func cancel():
	blackboard.set("state","abort")
