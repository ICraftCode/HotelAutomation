require './state'
require './sensor_input'
require './equipment_consumption'
require './equipment_type'

class Controller
	#@current_state
	@building

	# def default_state
	   #call while building in main.rb
	# end

	# def initialize current_state
	# 	@current_state = current_state
	# end

	def current_state
		@building.floors.each do |floor|
			floor.areas.each do |area|
				area.stringify
			end
		end
	end

	def initialize building
		@building = building
	end

	def switch_off equipment
		equipment.current_state = State::OFF
	end
	def switch_on equipment
		#verify_power_limit equipment
		equipment.current_state = State::ON
	end


	def power_limit_exceeded? floor #should this be going into floor
		current_power_consumption = 0
		floor.areas.each do |area|
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
		current_power_consumption > floor.allowed_power_consumption
	end

	def sub_corridor_control floor, subcorridor

        #actually check if this is subcorridor and do this; if main corridor may be u have to do somethingelse

		floor_to_update = @building.floors.find{|f| f.number == floor.number}
	    sub_corridor = floor_to_update.areas.find{|area| area.name == subcorridor.name}
	    subcorridor_lights = subcorridor.equipments.select{|e| e.type == EquipmentType::LIGHT}


	    subcorridor_lights.each do |light|
	    	switch_on light
	    	puts "switching on #{subcorridor.name} light"
	    	current_state
	    	#should also immediately update current state
	    end

	    puts "Has power consumption exceeded for Floor #{floor.number}?"
	    puts power_limit_exceeded? @building.floors.find{|f| f.number == floor.number}

	end

	# def main_corridor_control
	# end

	def process_sensor_input sensor_input

		puts sensor_input
		#assuming input is strictly of the format 'floor 1 mc 1'
		floor_number = sensor_input.split(' ')[1]
        floor = @building.floors.find{|f| f.number.to_s == floor_number}
        area = floor.areas.find{|a| a.name == sensor_input}
        sub_corridor_control floor, area
	end
end