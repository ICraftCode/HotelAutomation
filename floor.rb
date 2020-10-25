require './area'

class Building
	class Floor
		attr_accessor :areas
		attr_accessor :number
		attr_accessor :name
		# class Area
		# 	def initialize
		# 		puts "inside area constructor"
		# 	end
		# end

		def initialize number, num_of_mc_in_each_floor, num_of_sc_in_each_floor
			#this can be modularized
            @areas = Array.new

			@number = number
			@name = "Floor " + number.to_s
			
			(0...num_of_mc_in_each_floor).each do |mc|
	    		main_corridor = Main_Corridor.new("Floor "+@number.to_s+" mc "+(mc+1).to_s)
	    		@areas << main_corridor 
			end
			(0...num_of_sc_in_each_floor).each do |sc|
				sub_corridor = Sub_Corridor.new("Floor "+@number.to_s+" sc "+(sc+1).to_s)
	    		@areas << sub_corridor
			end
		end
	end
end