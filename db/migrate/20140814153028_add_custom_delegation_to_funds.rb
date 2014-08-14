class AddCustomDelegationToFunds < ActiveRecord::Migration
  def change
    add_column :funds, :custom_delegation, :string
  end
end
