class AddUserIdToTasks < ActiveRecord::Migration[6.1]
  def change
    # add a column for user_id
    add_belongs_to :tasks, :user
  end
end
