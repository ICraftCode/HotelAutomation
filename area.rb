require './state'
require './equipment_type'
require './equipment'

module Area
	attr_accessor :equipments
	attr_accessor :name
	#also has subareas - say a floor has main corridor and subcorridors. but skipping for now
	def initialize_equipments (equipment_list)
		#should we configure somewhere that mc has one light one ac.. how to easily add a tv
		@equipments = Array.new
		equipment_list.each do | equipment_type, equipment_detail |
			number = equipment_detail[0]
      		default_state = equipment_detail[1]

      		number.times do

	  			case equipment_type
	    			when EquipmentType::LIGHT
	    				@equipments << Light.new(@name, default_state, self)
	      			when EquipmentType::AC
	      				@equipments << AC.new(@name, default_state, self)
	    			else
	      				puts "Error: unsupported equipment type"
	    		end
    	    end
		end
	end


	def stringify
		@equipments.each do |equipment|
			puts "#{equipment.name} which has a default state of #{equipment.current_state}"
		end

		puts "*******************************************************************************"

	end

	# def equipments equipment_type
	# 	@equipments.select { |equipment| equipment.type == equipment_type }
	# end
end

#more proper - class floor composed of maincorridor, subcorridor etc

class Main_Corridor
	include Area
	def initialize name
		@name = name
		equipment_list = {}
		equipment_list[EquipmentType::LIGHT] = [1, State::ON]
		equipment_list[EquipmentType::AC] = [1, State::ON]
		initialize_equipments(equipment_list)
		#puts @name
	end

end

class Sub_Corridor
	include Area
	def initialize name
		@name = name
		equipment_list = {}
		equipment_list[EquipmentType::LIGHT] = [1, State::OFF]
		equipment_list[EquipmentType::AC] = [1, State::ON]
		initialize_equipments(equipment_list)
		#puts @name
	end
end

# class Rest_Room < Area
# end

# class TV_Room < Area
# end

# mc = Main_Corridor.new
# sc1 = Sub_Corridor.new "sub corridor 1"
# sc2 = Sub_Corridor.new "sub corridor 2"
