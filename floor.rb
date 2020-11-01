require './area'
require './area_type'

class Building
	class Floor
		attr_accessor :areas
		attr_accessor :number
		attr_accessor :allowed_power_consumption
		# attr_accessor :name
		# class Area
		# 	def initialize
		# 		puts "inside area constructor"
		# 	end
		# end

		def initialize number, num_of_mc_in_each_floor, num_of_sc_in_each_floor
			#floor::area instead of independent area

			
			#this can be modularized
            @areas = Array.new

			@number = number
			# @name = "Floor " + number.to_s
			
			(0...num_of_mc_in_each_floor).each do |mc|
	    		main_corridor = Main_Corridor.new("Floor "+@number.to_s+" mc "+(mc+1).to_s, AreaType::MC)
	    		@areas << main_corridor 
			end
			(0...num_of_sc_in_each_floor).each do |sc|
				sub_corridor = Sub_Corridor.new("Floor "+@number.to_s+" sc "+(sc+1).to_s, AreaType::SC)
	    		@areas << sub_corridor
			end

			@allowed_power_consumption = num_of_mc_in_each_floor * 15 + num_of_sc_in_each_floor * 10
		end


		def power_limit_exceeded?  #should this be going into floor
			current_power_consumption = 0
			self.areas.each do |area|
				area.equipments.each do |equipment|
					equipment_consumption = 0
					case equipment.type
					when EquipmentType::LIGHT
						equipment_consumption = EquipmentConsumption::LIGHT
					when EquipmentType::AC
						equipment_consumption = EquipmentConsumption::AC
					end
					if equipment.current_state == State::ON
						current_power_consumption = current_power_consumption + equipment_consumption
					end
				end
		    end
			current_power_consumption > self.allowed_power_consumption
		end
	end
end