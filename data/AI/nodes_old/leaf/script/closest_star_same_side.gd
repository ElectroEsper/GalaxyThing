extends BehaviorTree



func tick(actor, blackboard):
	
	var location = blackboard.get("LOCATION")
	var connected_stars = location.linked_systems
	for a in connected_stars:
		if(a.get_meta("SIDE")=="OWNED"):
			blackboard.set("DESTINATION",[a,a.astar_id])
			blackboard.set("PATH NXT WP",[a,a.astar_id])
			return SUCCESS
	return FAILED

