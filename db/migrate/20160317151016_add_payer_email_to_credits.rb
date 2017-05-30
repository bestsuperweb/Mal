class AddPayerEmailToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :payer_email, :string
  end
end
