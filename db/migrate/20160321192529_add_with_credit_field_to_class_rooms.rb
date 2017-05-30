class AddWithCreditFieldToClassRooms < ActiveRecord::Migration
  def change
    add_column :class_rooms, :with_credit, :boolean, default: true
  end
end
