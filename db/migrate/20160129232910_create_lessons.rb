class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
    	t.belongs_to :user, index: true
    	t.string :name
    	t.string :level
    	t.text :description
    	t.string :duration
      t.timestamps null: false
    end
  end
end
