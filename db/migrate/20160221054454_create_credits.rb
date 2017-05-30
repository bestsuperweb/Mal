class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer :user_id
      t.string :status, default: "purchased"

      t.timestamps null: false
    end
  end
end
