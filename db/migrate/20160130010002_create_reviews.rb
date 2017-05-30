class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
    	t.belongs_to :user, index: true
    	t.string :body
      t.timestamps null: false
    end
  end
end
