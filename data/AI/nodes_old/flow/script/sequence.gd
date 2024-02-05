extends BehaviorTree


# Execute EVERY CHILD in order, UNTIL one of them fails
func tick(actor,blackboard):
	for c in get_children():
		var response = c.tick(actor, blackboard)
		if response is GDScriptFunctionState:
			response = await response.completed
		if response != SUCCESS:
			return response

	return SUCCESS
