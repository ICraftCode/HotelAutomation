require './state'
require './sensor_input'
require './equipment_consumption'
require './equipment_type'
require './area_type'

class Controller
	attr_accessor :building
	@switched_on_subcorridor_lights
	@switched_off_subcorridor_acs
    @last_input_time

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
		@switched_on_subcorridor_lights = []
		@switched_off_subcorridor_acs = []
	end

	def process_sensor_input sensor_input_area, sensor_input_time
		turn_subcorridor_lights_off(sensor_input_area, sensor_input_time)
		turn_subcorridor_acs_on(sensor_input_area, sensor_input_time)
        @last_input_time = sensor_input_time
		floor_number = sensor_input_area.split(' ')[1]
		floor = @building.floors.find{|f| f.number.to_s == floor_number}
		area = floor.areas.find{|a| a.name == sensor_input_area}
        area.last_movement_time = sensor_input_time
        sub_corridor_control floor, area
	end

	private

	def switch_off equipment
		equipment.current_state = State::OFF
	end
	def switch_on equipment
		equipment.current_state = State::ON
	end

	def turn_sub_corridor_acs_off floor
		subcorridors = floor.areas.select{|area| area.area_type == AreaType::SC}
		subcorridors.sort_by! { |subcorridor| subcorridor.last_movement_time }
		subcorridors.each do |subcorridor|
			enough_acs_turned_off = false
			subcorridor_acs = subcorridor.equipments.select{|equipment| equipment.type == EquipmentType::AC}
			subcorridor_acs.each do |ac|
				if floor.power_limit_exceeded?
					switch_off ac
					puts "Switching off #{ac.name}"
					@switched_off_subcorridor_acs.push([ac, @last_input_time])
				else
                    enough_acs_turned_off = true
					break
				end
			end
			break if enough_acs_turned_off
		end
	end


	def sub_corridor_control floor, subcorridor

		floor_to_update = @building.floors.find{|f| f.number == floor.number}
	    sub_corridor = floor_to_update.areas.find{|area| area.name == subcorridor.name}
	    subcorridor_lights = subcorridor.equipments.select{|e| e.type == EquipmentType::LIGHT}


	    subcorridor_lights.each do |light|
	    	switch_on light
	    	puts "switching on #{light.name}"
	    	@switched_on_subcorridor_lights.push([light, @last_input_time])
	    end

	    if floor_to_update.power_limit_exceeded? 
	    	puts "Power consumption has exceeded for Floor #{floor.number}"
	        turn_sub_corridor_acs_off floor
	    end

	end

	def turn_subcorridor_lights_off sensor_input_area, sensor_input_time
		@switched_on_subcorridor_lights.each do |on_light|
        	if on_light[1]+1*60 < sensor_input_time
        		switch_off on_light[0]
        		puts "switching off #{on_light[0].name}"
        		@switched_on_subcorridor_lights.delete on_light
        	else
        		if on_light[0].name == sensor_input_area #extending by another minute
        			on_light[1] = sensor_input_time
        	    end
        	end
        end
	end

	def turn_subcorridor_acs_on sensor_input_area, sensor_input_time
		@switched_off_subcorridor_acs.each do |off_ac|
        	if off_ac[1]+1*60 < sensor_input_time
        		switch_on off_ac[0]
        		puts "Switching on #{off_ac[0].name}"
        		@switched_off_subcorridor_acs.delete off_ac
        	else
        		if off_ac[0].name == sensor_input_area #extending by another minute
        			off_ac[1] = sensor_input_time
        	    end
        	end
        end
	end


end