extends BehaviorTree

# FUNCTION
#
# CHECKS IF UNIT IS IDLE
#
#

func tick(actor, blackboard):
	var child = self.get_child(0)
	var status = blackboard.get("STATUS")

	if status == "REPAIR":
		return child.tick(actor, blackboard)
	return FAILED


