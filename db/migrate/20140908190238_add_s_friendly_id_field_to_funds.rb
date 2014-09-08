class AddSFriendlyIdFieldToFunds < ActiveRecord::Migration
  def change
    add_column :funds, :friendly_id, :string
  end
end
