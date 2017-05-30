class ChangePriceColumnTypeInCredits < ActiveRecord::Migration
  def change
  	change_column :credits, :price, :float, precision: 2
  end
end
