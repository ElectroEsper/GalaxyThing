extends BehaviorTree



func tick(actor, blackboard):
	
	blackboard.set("STATUS","MOVE")
	
	return SUCCESS

