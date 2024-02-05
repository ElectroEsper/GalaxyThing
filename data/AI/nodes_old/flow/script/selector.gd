extends BehaviorTree

# Find and execute the FIRST CHILD that does not fail
func tick(actor, blackboard):
	for c in get_children():
		var response = c.tick(actor,blackboard)
		if response is GDScriptFunctionState:
			response = await response.completed
		if response != FAILED:
			return response
	
	return FAILED
