class AddInfoToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :address, :string
  	add_column :users, :city, :string
  	add_column :users, :phone, :string
  	add_column :users, :description, :text
  end
end
