extends BehaviorTree



func tick(actor, blackboard):
	
	var location = blackboard.get("LOCATION")
	var destination = blackboard.get("DESTINATION")
	
	if destination == null:
		blackboard.set("STATUS","IDLE")
		return FAILED
	else:
		var astar = GFunctions._find_path_location(location,destination)
		blackboard.set("PATH",astar)
		
	var path = blackboard.get("PATH")
	var path_idx = blackboard.get("PATH IDX")
	
	
	
	if(path_idx == null):
		path_idx = 1
		blackboard.set("PATH NXT WP",[path[0][path_idx],path[1][path_idx]])
		path_idx+=1
		return SUCCESS
	elif(path_idx == path.size()):
		return SUCCESS
	else:
		blackboard.set("PATH NXT WP",[path[0][path_idx],path[1][path_idx]])
		path_idx+=1
		return SUCCESS

	return FAILED

