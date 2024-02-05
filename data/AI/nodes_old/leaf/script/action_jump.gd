extends BehaviorTree

func tick(actor, blackboard):
	var moveTween = actor.moveTween
	var location = blackboard.get("LOCATION")
	var destination = blackboard.get("DESTINATION")
	var next_wp = blackboard.get("PATH NXT WP")
	
	var response = null
	
	var state = blackboard.get("state")
	var status = blackboard.get("STATUS")
	
	if(state == "abort"):
		return FAILED
	if status == "MOVE":
		response = startTween(moveTween,GVariables.ASTAR.get_point_position(location[1]),GVariables.ASTAR.get_point_position(next_wp[1]))
		var leaving =  location[0].blackboard.get("LEAVING FLEETS")
		leaving.append(actor)
		location[0].blackboard.set("LEAVING FLEETS",leaving)
		blackboard.set("STATUS","MOVING")
		return RUNNING
	
	if actor.position.distance_to(next_wp[0].position) > 0:
		return RUNNING
			
	# ONCE FLEET ARRIVED AT NEXT WP
	blackboard.set("LOCATION",next_wp)
	var arr = next_wp[0].blackboard.get("UNSORTED FLEETS")
	arr.append(actor)
	next_wp[0].blackboard.set("UNSORTED FLEETS",arr)
	
	if next_wp[0] == destination[0]:
		blackboard.set("STATUS","IDLE")
		blackboard.set("DESTINATION",null)
		blackboard.set("PATH NXT WP",null)
	
	blackboard.set("STATUS","MOVE")
		
	return SUCCESS

func startTween(moveTween,from,to):
	var actor = moveTween.get_parent()
	var done = false
	moveTween.start()
	moveTween.interpolate_property(actor, "position", from, to, 2, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	
	await moveTween.tween_completed
	done = true
	return done
	
