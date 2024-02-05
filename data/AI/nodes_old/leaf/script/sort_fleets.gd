extends BTLeaf

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var unsorted_fleets = blackboard.get("UNSORTED FLEETS")
	var allied_fleet = blackboard.get("ALLIED FLEETS")
	var hostile_fleet = blackboard.get("HOSTILE FLEETS")
	var leaving_fleet = blackboard.get("LEAVING FLEETS")
	var side = blackboard.get("SIDE")
	if unsorted_fleets.size()>0:
		for a in unsorted_fleets:
			var side_a = a.blackboard.get("SIDE")
			if side_a == side :
				allied_fleet = blackboard.get("ALLIED FLEETS")
				allied_fleet.append(a)
				blackboard.set("ALLIED FLEETS",allied_fleet)
			else:
				hostile_fleet = blackboard.get("HOSTILE FLEETS")
				hostile_fleet.append(a)
				blackboard.set("HOSTILE FLEETS",hostile_fleet)
		blackboard.set("UNSORTED FLEETS",[])
		return SUCCESS
	if leaving_fleet.size()>0:
		for a in leaving_fleet:
			if allied_fleet.has(a):
				allied_fleet.erase(a)
				blackboard.set("ALLIED FLEETS",allied_fleet)
			if hostile_fleet.has(a):
				hostile_fleet.erase(a)
				blackboard.set("HOSTILE FLEETS",hostile_fleet)
			leaving_fleet.erase(a)
		return SUCCESS
	return FAILED



