require './floor'
class Building
	attr_accessor :floors

	#building is composed of floors - composition
	#floor is composed of areas - compostion
	# area has equipments but equipments can exist individually - not composition just association
    
    #how to define this Floor class in a separate file but cannot be accessed outside building

	# class Floor
	# 	# attr_accessor :areas
	# 	class Area
	# 		def initialize
	# 			puts "inside area constructor"
	# 		end
	# 	end

	# 	def initialize
	# 		area = Area.new()
	# 		puts "inside floor constructor"
	# 	end
	# end

	#instead of numofmc and sc are params, that should be a hash or so because any other area can also be added

	def initialize num_of_floors, num_of_mc_in_each_floor, num_of_sc_in_each_floor
		@floors = Array.new
		(0...num_of_floors).each do |i|
			@floors[i] = Floor.new i+1, num_of_mc_in_each_floor, num_of_sc_in_each_floor
		end
    end

    
	# def initialize 
	# 	floor = Floor.new()
	# 	puts "inside building constructor"
	# end
end

#Building.new 