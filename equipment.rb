
require './state'
require './power_consumption'
require './equipment_type'

class Equipment
	attr_accessor :name
	attr_accessor :default_state
	attr_accessor :current_state
	@area
	@power_consumption
	attr_accessor :type
end

class Light < Equipment
	def initialize name_prefix, default_state, area
		@name = name_prefix + " Light"
		@power_consumption = Power_Consumption::LIGHT_PC
		@default_state = default_state
		@current_state = default_state
		@area = area
		@type = EquipmentType::LIGHT
	end
end

class AC < Equipment
	def initialize name_prefix, default_state, area
		@name = name_prefix + " AC"
		@power_consumption = Power_Consumption::AC_PC
		@default_state = default_state
		@current_state = default_state
		@area = area
		@type = EquipmentType::AC
	end
end

