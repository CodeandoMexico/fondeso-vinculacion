class AddGeographicOperatorToFunds < ActiveRecord::Migration
  def change
    add_column :funds, :geographic_operator, :string
  end
end
