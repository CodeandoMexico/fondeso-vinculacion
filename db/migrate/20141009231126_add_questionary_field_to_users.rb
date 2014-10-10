class AddQuestionaryFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :questionary, :text
  end
end
