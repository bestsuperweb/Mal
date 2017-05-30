class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.text :body
    	t.references :class_room, index: true
    	t.references :user, index: true
      t.timestamps null: false
    end
  end
end
