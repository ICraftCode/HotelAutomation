require './state'
require './sensor_input'
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

	def sub_corridor_control subcorridor

		current_state

		subcorridor_lights = subcorridor.equipments.select{|e| e.type == EquipmentType::LIGHT}

	    subcorridor_lights.each do |light|
	    	switch_on light
	    	puts "switching on #{subcorridor.name} light"
	    	current_state
	    	#should also immediately update current state
	    end

	end

	# def main_corridor_control
	# end

	def process_sensor_input sensor_input
		#assuming input is strictly of the format 'floor 1 mc 1'
		floor_number = sensor_input.split(' ')[1]
        floor = @building.floors.find{|f| f.number.to_s == floor_number}
        area = floor.areas.find{|a| a.name == sensor_input}
        sub_corridor_control area
	end
end