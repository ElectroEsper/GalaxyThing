extends BTLeaf
class_name SetStatusIdle


# (Optional) Do something BEFORE tick result is returned.
"""
func _pre_tick(agent: Node, blackboard: Blackboard) -> void:
	if not blackboard.get_data("pre_key"):
		blackboard.set_data("not_ready_yet", true)
		print("Not ready yet.")
		return
"""

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	blackboard.set_data("STATUS","IDLE")
	return succeed()

"""
# (Optional) Do something AFTER tick result is returned.
func _post_tick(agent: Node, blackboard: Blackboard, result: bool) -> void:
	blackboard.set_data("last_result", result)
	agent.call("another_method", result)
"""
