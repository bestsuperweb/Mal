class AddCountsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lesson_count, :integer
    add_column :users, :current_rating, :integer
  end
end
