extends BehaviorTree

func tick(actor, blackboard):
	var child = self.get_child(0)
	var contact_report = blackboard.get("CONTACT REPORT")
	
	if contact_report:
		return child.tick(actor, blackboard)
	return FAILED



