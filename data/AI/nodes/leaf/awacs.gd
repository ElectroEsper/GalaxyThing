extends BTLeaf
class_name AWACS


# (Optional) Do something BEFORE tick result is returned.
"""
func _pre_tick(agent: Node, blackboard: Blackboard) -> void:
	if not blackboard.get_data("pre_key"):
		blackboard.set_data("not_ready_yet", true)
		print("Not ready yet.")
		return
"""

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	if not blackboard.get_data("CONTACT ALERT"):
		if blackboard.get_data("HOSTILE FLEETS").size()>0:
			blackboard.set_data("CONTACT ALERT",true)
			return succeed()
	return fail()

"""
# (Optional) Do something AFTER tick result is returned.
func _post_tick(agent: Node, blackboard: Blackboard, result: bool) -> void:
	blackboard.set_data("last_result", result)
	agent.call("another_method", result)
"""
