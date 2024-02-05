extends BTLeaf

"""
# (Optional) Do something BEFORE tick result is returned.
func _pre_tick(agent: Node, blackboard: Blackboard) -> void:
	if not blackboard.get_data("pre_key"):
		blackboard.set_data("not_ready_yet", true)
		print("Not ready yet.")
		return
"""

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	#assert(agent.has_method("my_method"))
	var unsorted_fleets = blackboard.get_data("UNSORTED FLEETS")
	var allied_fleets = blackboard.get_data("ALLIED FLEETS")
	var hostile_fleets = blackboard.get_data("HOSTILE FLEETS")
	var leaving_fleets = blackboard.get_data("LEAVING FLEETS")
	var side = blackboard.get_data("SIDE")
	
	if unsorted_fleets.size()>0:
		for a in unsorted_fleets:
			var side_a = a.blackboard.get_data("SIDE")
			if side_a == side :
				#allied_fleets = blackboard.get_data("ALLIED FLEETS")
				#allied_fleets.append(a)
				blackboard.set_data("ALLIED FLEETS",blackboard.get_data("ALLIED FLEETS").append(a))
			else:
				leaving_fleets = blackboard.get_data("HOSTILE FLEETS")
				leaving_fleets.append(a)
				blackboard.set_data("HOSTILE FLEETS",leaving_fleets)
		blackboard.set_data("UNSORTED FLEETS",[])
		return succeed()
	
	if leaving_fleets.size()>0:
		for a in leaving_fleets:
			if blackboard.get_data("ALLIED FLEETS").has(a):
				blackboard.set_data("ALLIED FLEETS",blackboard.get_data("ALLIED FLEETS").erase(a))
			if blackboard.get_data("HOSTILE FLEETS").has(a):
				blackboard.set_data("HOSTILE FLEETS",blackboard.get_data("HOSTILE FLEETS").erase(a))	
		blackboard.set_data("LEAVING FLEETS",[])
		return succeed()
	return fail()
	
	
	# If action is executing, wait for completion and remain in running state
	#if result is GDScriptFunctionState:
		# Store what the action returns when completed
	#	result = yield(result, "completed") 
	
	# If action returns anything but a bool consider it a success
	#if not result is bool: 
	#	result = true
	
	# Once action is complete we return either success or failure.
	#if result:
	#	return succeed()
	#return fail()

"""
# (Optional) Do something AFTER tick result is returned.
func _post_tick(agent: Node, blackboard: Blackboard, result: bool) -> void:
	blackboard.set_data("last_result", result)
	agent.call("another_method", result)
"""
