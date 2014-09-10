class AddPriorityColumnToFund < ActiveRecord::Migration
  def change
    add_column :funds, :priority, :string
  end
end
