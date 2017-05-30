class AddDefaultToType < ActiveRecord::Migration
  def change
    change_column :users, :user_type, :string, default: "Student"
  end
end
