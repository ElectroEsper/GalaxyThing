extends BehaviorTree



func tick(actor, blackboard):
	
	blackboard.set("STATUS","IDLE")
	
	return SUCCESS

