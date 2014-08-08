class ChangeDescriptionColumnType < ActiveRecord::Migration
    def up
      change_column :funds, :description, :text
    end

    def down
      change_column :funds, :description, :string
    end
end
