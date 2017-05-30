class AddInstrumentToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :instrument, :string
  end
end
