require './area'

#to be read from file or test cases

def initial_state num_of_floors, num_of_mc_in_each_floor, num_of_sc_in_each_floor 
	initial_state = Array.new
	(0...num_of_floors).each do |floor|
		area_name = "floor " + (floor+1).to_s
		initial_state[floor] = Array.new 
		(0...num_of_mc_in_each_floor).each do |mc|
	    	main_corridor = Main_Corridor.new(area_name+" mc "+ (mc+1).to_s)
	    	initial_state[floor] << main_corridor 
		end
		(0...num_of_sc_in_each_floor).each do |sc|
			sub_corridor = Sub_Corridor.new(area_name+" sc "+ (sc+1).to_s)
	    	initial_state[floor] << sub_corridor
		end
	end
	return initial_state
end

# puts initial_state
# [
# 	[{},{},{}],
#     [{},{},{}]
# ]



num_of_floors = 2
num_of_mc_in_each_floor = 1
num_of_sc_in_each_floor = 2

initial_state = initial_state num_of_floors, num_of_mc_in_each_floor, num_of_sc_in_each_floor

# initial_state.each do |floor|
# 	floor.each do |corridor|
# 		corridor.to_s
# 	end
# end


