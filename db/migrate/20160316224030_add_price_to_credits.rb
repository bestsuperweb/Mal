class AddPriceToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :price, :integer
  end
end
