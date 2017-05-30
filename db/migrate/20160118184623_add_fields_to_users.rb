class AddFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :user_type, :string
  	add_column :users, :notifications, :boolean
  end
end
