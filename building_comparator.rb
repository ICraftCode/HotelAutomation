class BuildingComparator

def self.compare building1, building2
      return false if building1.floors.count != building2.floors.count
      building1.floors.sort_by! { |floor| floor.number }
      building2.floors.sort_by! { |floor| floor.number }

      building1.floors.each do |b1floor|
         building2.floors.each do |b2floor|
            return false if b1floor.areas.count != b2floor.areas.count
         end
      end
      b1_equipments = []
      b2_equipments = []

      building1.floors.each do |b1floor|
      	b1floor.areas.sort_by! {|area| area.name}
      	b1floor.areas.each do |b1area|
      		b1area.equipments.sort_by! {|equipment| equipment.name}
      		b1area.equipments.each do |b1equipment|
      			b1_equipments.push b1equipment
      		end
      	end
      end

       building2.floors.each do |b2floor|
      	b2floor.areas.sort_by! {|area| area.name}
      	b2floor.areas.each do |b2area|
      		b2area.equipments.sort_by! {|equipment| equipment.name}
      		b2area.equipments.each do |b2equipment|
      			b2_equipments.push b2equipment
      		end
      	end
      end

      return false if b1_equipments.count != b2_equipments.count

      i = 0

      while i<b1_equipments.count
      	if b1_equipments[i].current_state != b2_equipments[i].current_state
      		return false
      	end
      	i = i+1
      end
  

      return true


   end
end