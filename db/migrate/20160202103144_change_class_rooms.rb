class ChangeClassRooms < ActiveRecord::Migration
  def change
  	change_column :class_rooms, :approve, :boolean, default: false
  end
end
