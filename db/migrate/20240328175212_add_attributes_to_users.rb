class AddAttributesToUsers < ActiveRecord::Migration[6.1]
  def change
    # add columns for username and password
    add_column :users, :username, :string
    add_column :users, :password, :string
  end
end
