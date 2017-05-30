class CreateUserInstruments < ActiveRecord::Migration
  def change
    create_table :user_instruments do |t|
      t.integer :user_id
      t.integer :instrument_id
      t.timestamps
    end

    create_table :user_genres do |t|
      t.integer :user_id
      t.integer :genre_id
      t.timestamps
    end

    create_table :user_levels do |t|
      t.integer :user_id
      t.integer :level_id
      t.timestamps
    end
  end
end
