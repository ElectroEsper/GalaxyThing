extends BehaviorTree

func tick(actor, blackboard):
	var child = self.get_child(0)
	

	if SUCCESS:
		return child.tick(actor, blackboard)
	return FAILED



