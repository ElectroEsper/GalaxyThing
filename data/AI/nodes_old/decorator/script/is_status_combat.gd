extends BehaviorTree

func tick(actor, blackboard):
	var child = self.get_child(0)
	var status = blackboard.get("STATUS")

	if status == "COMBAT":
		return child.tick(actor, blackboard)
	return FAILED


