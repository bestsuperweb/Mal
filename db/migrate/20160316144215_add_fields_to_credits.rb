class AddFieldsToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :ip, :string
    add_column :credits, :express_token, :string
    add_column :credits, :express_payer_id, :string
  end
end
