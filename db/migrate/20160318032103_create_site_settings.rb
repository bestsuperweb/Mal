class CreateSiteSettings < ActiveRecord::Migration
  def change
    create_table :site_settings do |t|
      t.string :key
      t.string :value

      t.timestamps null: false
    end
  end
end
