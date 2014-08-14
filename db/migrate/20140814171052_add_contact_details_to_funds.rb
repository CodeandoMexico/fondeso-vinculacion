class AddContactDetailsToFunds < ActiveRecord::Migration
  def change
    add_column :funds, :contact_details, :text
  end
end
