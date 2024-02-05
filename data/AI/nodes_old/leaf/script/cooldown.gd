extends BehaviorTree

@onready var state
@export var timer : int = 0



func tick(actor, blackboard):
	
	#while(time_out<timer):
	#	state = blackboard.get("state")
	#	if(state == "abort"):
	#		return FAILED
	await clock(blackboard,timer).completed
		#time_out += 0.1
	return SUCCESS
	
	
	"""
	if blackboard.get("TIMER") == null:
		var timekeeper = TimeKeeper.days_raw
		blackboard.set("TIMER",timekeeper+timer)
		
	while blackboard.get("TIMER") > TimeKeeper.days_raw:
		pass
	blackboard.set("TIMER",null)
	return SUCCESS	
	else:
		if blackboard.get("TIMER") > TimeKeeper.days_raw:
			return RUNNING
		elif blackboard.get("TIMER") == TimeKeeper.days_raw:
			blackboard.set("TIMER",null)
			return SUCCESS
	"""

func clock(blackboard,timer):
	var time_out = 0
	await get_tree().idle_frame
	await get_tree().create_timer(timer, false).timeout
	
	
