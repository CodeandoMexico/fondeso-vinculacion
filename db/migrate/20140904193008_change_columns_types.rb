class ChangeColumnsTypes < ActiveRecord::Migration
  def up
      change_column :funds, :characteristics, :text
      change_column :funds, :deliver_method, :text
      change_column :funds, :clasification, :text
      change_column :funds, :special_filters, :text
  end
  def down
      # This might cause trouble if you have strings longer
      # than 255 characters.
      change_column :funds, :characteristics, :string
      change_column :funds, :deliver_method, :string
      change_column :funds, :clasification, :string
      change_column :funds, :special_filters, :string
  end
end
