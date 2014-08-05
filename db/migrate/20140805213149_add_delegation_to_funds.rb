class AddDelegationToFunds < ActiveRecord::Migration
  def change
    add_column :funds, :home_delegation, :string
    add_column :funds, :business_delegation, :string
  end
end
