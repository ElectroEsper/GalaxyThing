extends BehaviorTree



func tick(actor, blackboard):
	
	blackboard.set("STATUS","COMBAT")
	
	return SUCCESS

