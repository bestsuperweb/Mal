class AddInstrumentToTeacherStuff < ActiveRecord::Migration
  def change
    add_column :teacher_stuffs, :instrument, :string
  end
end
