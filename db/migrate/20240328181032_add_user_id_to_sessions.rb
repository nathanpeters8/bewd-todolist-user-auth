class AddUserIdToSessions < ActiveRecord::Migration[6.1]
  def change
    # add a column for user_id (shortcut for add_column :sessions, :user_id)
    add_belongs_to :sessions, :user
  end
end
