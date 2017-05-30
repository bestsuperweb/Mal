class CreateExternalLinks < ActiveRecord::Migration
  def change
    create_table :external_links do |t|
      t.integer :user_id
      t.string :url

      t.timestamps null: false
    end
  end
end
