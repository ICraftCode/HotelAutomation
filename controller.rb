require './state'
require './sensor_input'
require './equipment_consumption'
require './equipment_type'
require './area_type'

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
		puts "                       CURRENT STATE"
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

	def turn_sub_corridor_lights_off floor
		subcorridors = floor.areas.select{|area| area.area_type == AreaType::SC}
		subcorridors.sort_by! { |subcorridor| subcorridor.last_movement_time }
		subcorridors.each do |subcorridor|
			enough_acs_turned_off = false
			subcorridor_acs = subcorridor.equipments.select{|equipment| equipment.type == EquipmentType::AC}
			subcorridor_acs.each do |ac|
				if floor.power_limit_exceeded?
					switch_off ac
				else
                    enough_acs_turned_off = true
					break
				end
			end
			break if enough_acs_turned_off
		end
		current_state
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

	    f = @building.floors.find{|f| f.number == floor.number}

	    if f.power_limit_exceeded? 
	    	puts "Power consumption has exceeded for Floor #{floor.number}"
	        turn_sub_corridor_lights_off floor
	    end

	end

	# def main_corridor_control
	# end

	def process_sensor_input sensor_input_area, sensor_input_time

		#puts sensor_input
		#assuming input is strictly of the format 'floor 1 mc 1'
		floor_number = sensor_input_area.split(' ')[1]
        floor = @building.floors.find{|f| f.number.to_s == floor_number}
        area = floor.areas.find{|a| a.name == sensor_input_area}
        area.last_movement_time = sensor_input_time
        sub_corridor_control floor, area
	end
end