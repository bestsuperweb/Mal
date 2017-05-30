class AddApproveToClassRoomsTable < ActiveRecord::Migration
  def change
    add_column :class_rooms, :approve, :boolean
  end
end
