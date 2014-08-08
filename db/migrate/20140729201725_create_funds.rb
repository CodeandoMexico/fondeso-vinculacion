class CreateFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.string :name
      t.string :description
      t.string :institution
      t.string :charactistics
      t.string :deliver_method
      t.string :clasification
      t.string :special_filters

      t.timestamps
    end
  end
end
