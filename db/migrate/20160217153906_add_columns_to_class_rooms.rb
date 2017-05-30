class AddColumnsToClassRooms < ActiveRecord::Migration
  def change
  	add_column :class_rooms, :sessionId, :string
  	add_column :class_rooms, :public, :boolean, default: false
  end
end
