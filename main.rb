require './area'
require './controller'
require './building'

#to be read from file or test cases

# def initial_state num_of_floors, num_of_mc_in_each_floor, num_of_sc_in_each_floor 
# 	initial_state = Array.new
# 	(0...num_of_floors).each do |floor|
# 		area_name = "floor " + (floor+1).to_s
# 		initial_state[floor] = Array.new 
# 		(0...num_of_mc_in_each_floor).each do |mc|
# 	    	main_corridor = Main_Corridor.new(area_name+" mc "+ (mc+1).to_s)
# 	    	initial_state[floor] << main_corridor 
# 		end
# 		(0...num_of_sc_in_each_floor).each do |sc|
# 			sub_corridor = Sub_Corridor.new(area_name+" sc "+ (sc+1).to_s)
# 	    	initial_state[floor] << sub_corridor
# 		end
# 	end
# 	return initial_state
# end

# puts initial_state
# [
# 	[{},{},{}],
#     [{},{},{}]
# ]



num_of_floors = 2
num_of_mc_in_each_floor = 1
num_of_sc_in_each_floor = 2

# initial_state = initial_state num_of_floors, num_of_mc_in_each_floor, num_of_sc_in_each_floor

#should controller be implemented as a singleton

#Controller.new(initial_state).process_sensor_input "floor 1 sc 2"

building = Building.new num_of_floors, num_of_mc_in_each_floor, num_of_sc_in_each_floor

#puts building.floors[0].areas[0].to_s

#should this be made singleton

controller = Controller.new(building)

#controller.current_state

controller.process_sensor_input "Floor 1 sc 1", 1






# initial_state.each do |floor|
# 	floor.each do |corridor|
# 		corridor.to_s
# 	end
# end




