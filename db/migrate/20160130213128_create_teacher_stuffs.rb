class CreateTeacherStuffs < ActiveRecord::Migration
  def change
    create_table :teacher_stuffs do |t|
    	t.belongs_to :user, index: true
    	t.string :about
    	t.string :music_experince
    	t.string :teach_experince
    	t.string :graduate
      t.timestamps null: false
    end
  end
end
