extends BehaviorTree



func tick(actor, blackboard):
	
	var contact_arr = blackboard.get("HOSTILE FLEETS")
	if(contact_arr.size()>0):
		blackboard.set("CONTACT REPORT",SUCCESS)
		return SUCCESS
	
	return FAILED

