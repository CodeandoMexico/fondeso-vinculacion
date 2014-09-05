class ChangePriorityType < ActiveRecord::Migration
  def up
    change_column :funds, :priority, :string
  end

  def down
    change_column :funds, :priority, :integer
  end
end
