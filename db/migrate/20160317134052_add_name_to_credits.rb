class AddNameToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :first_name, :string
    add_column :credits, :last_name, :string
  end
end
