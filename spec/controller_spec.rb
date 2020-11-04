require './controller'
require './building'
require './floor'
require './area'
require './equipment'
require './state'
require './equipment_type'
require 'json'
require './building_comparator'

RSpec.describe Controller do
   num_of_floors = 2
   num_of_mc_in_each_floor = 1
   num_of_sc_in_each_floor = 2
   building  = Building.new num_of_floors, num_of_mc_in_each_floor, num_of_sc_in_each_floor
   controller = Controller.new(building)
   expected_building = Building.new num_of_floors, num_of_mc_in_each_floor, num_of_sc_in_each_floor
   
   last_input_time = Time.now.getutc


   describe "sensor input is passed to controller" do
         sensor_input_area = "Floor 1 sc 2"
         sensor_input_time = Time.now.getutc + 30*60 # 30 mins after contoller is switched on
         floor_number = sensor_input_area.split(' ')[1]
         last_input_time = sensor_input_time
         controller.process_sensor_input(sensor_input_area, sensor_input_time)
         
      
      it "sensor input is processed and corresponding subcorridor lights turned on" do
         floor = expected_building.floors.find{|f| f.number.to_s == floor_number}
         area = floor.areas.find{|a| a.name == sensor_input_area}
         area.equipments.each do |equipment|
            equipment.current_state = State::ON if equipment.type == EquipmentType::LIGHT
         end

         

         actual_floor = controller.building.floors.find{|f| f.number.to_s == floor_number}
         actual_area = actual_floor.areas.find{|a| a.name == sensor_input_area}
         actual_area.equipments.each do |equipment|
            if equipment.type == EquipmentType::LIGHT
               expect equipment.current_state == State::ON
            end
         end
      end

      it "power limit is exceeded due to turning on off subcorridor lights" do
         floor = expected_building.floors.find{|f| f.number.to_s == floor_number}
         expect(floor.power_limit_exceeded?).to be true
      end

      it "corresponding subcorridor's acs are turned off to keep power consumption within limits" do
         floor = expected_building.floors.find{|f| f.number.to_s == floor_number}

         @switched_off_subcorridor_acs = []
         subcorridors = floor.areas.select{|area| area.area_type == AreaType::SC}
         subcorridors.sort_by! { |subcorridor| subcorridor.last_movement_time }
         subcorridors.each do |subcorridor|
            enough_acs_turned_off = false
            subcorridor_acs = subcorridor.equipments.select{|equipment| equipment.type == EquipmentType::AC}
            subcorridor_acs.each do |ac|
               if floor.power_limit_exceeded?
                  ac.current_state = State::OFF
                  @switched_off_subcorridor_acs.push([ac, @last_input_time])
               else
                  enough_acs_turned_off = true
                  break
               end
            end
            break if enough_acs_turned_off
         end

         expect(BuildingComparator.compare(controller.building, expected_building)).to be true


      end
   end

   describe "second sensor input which is same as first is passed to controller" do
      it "Sc lights remain on and some sc acs remain off" do
         expect(BuildingComparator.compare(controller.building, expected_building)).to be true
      end
   end 
end

