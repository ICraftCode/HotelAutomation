require './area'
require './controller'
require './building'
require './building_comparator'

num_of_floors = 2
num_of_mc_in_each_floor = 1
num_of_sc_in_each_floor = 2

building = Building.new num_of_floors, num_of_mc_in_each_floor, num_of_sc_in_each_floor

controller = Controller.new(building)

sensor_input_area = "Floor 1 sc 2"
sensor_input_time = Time.now.getutc + 30*60 # 30 mins after contoller is switched on
controller.process_sensor_input(sensor_input_area, sensor_input_time)
controller.current_state #to ptint for verification

sensor_input_area = "Floor 1 sc 1"
sensor_input_time = sensor_input_time + 3*60 #3 mins later

controller.process_sensor_input(sensor_input_area, sensor_input_time)
controller.current_state


   

 





# time = Time.now.getutc
# puts time
# puts time + 1*60
