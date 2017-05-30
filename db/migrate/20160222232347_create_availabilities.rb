class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.string :start_time
      t.string :end_time
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
