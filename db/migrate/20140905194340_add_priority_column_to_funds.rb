class AddPriorityColumnToFunds < ActiveRecord::Migration
  def change
    add_column :funds, :priority, :integer
  end
end
