extends Node

#class_name Blackboard

var blackboard = {}

func set(key, value, blackboard_name = 'default'):
	if not blackboard.has(blackboard_name):
		blackboard[blackboard_name] = {}
	
	blackboard[blackboard_name][key] = value

func get(key, blackboard_name = 'default'):
	if has(key, blackboard_name):
		return blackboard[blackboard_name][key]

func has(key, blackboard_name = 'default'):
	return blackboard.has(blackboard_name) and blackboard[blackboard_name].has(key) and blackboard[blackboard_name][key] != null
	
func erase(key, blackboard_name = 'default'):
	if blackboard.has(blackboard_name):
		blackboard[blackboard_name][key] = null
