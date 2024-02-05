extends BehaviorTree



func tick(actor, blackboard):
	var state = blackboard.get("state")
	if(state == "abort"):
		return FAILED
	
	######
	# CODE HERE
	#####
	
	
	return SUCCESS

