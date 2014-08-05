class RenameColumnInFunds < ActiveRecord::Migration
  def change
    rename_column :funds, :charactistics, :characteristics
  end
end
