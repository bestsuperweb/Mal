class AddIndexToReviews < ActiveRecord::Migration
  def change
    add_index :reviews, :author_id
  end
end
