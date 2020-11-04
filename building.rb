require './floor'
class Building
	attr_accessor :floors

	def initialize num_of_floors, num_of_mc_in_each_floor, num_of_sc_in_each_floor
		@floors = Array.new
		(0...num_of_floors).each do |i|
			@floors[i] = Floor.new i+1, num_of_mc_in_each_floor, num_of_sc_in_each_floor
		end
    end
end

