class AddAuthorIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :author_id, :integer
  end
end
