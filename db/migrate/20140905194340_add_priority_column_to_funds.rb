class AddPriorityColumnToFunds < ActiveRecord::Migration
  def change
    remove_column :funds, :priority
  end
end
