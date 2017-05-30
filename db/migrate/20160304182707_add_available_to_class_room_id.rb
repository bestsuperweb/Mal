class AddAvailableToClassRoomId < ActiveRecord::Migration
  def change
  	add_column :class_rooms, :availability_id, :integer, index: true
  end
end
