class AddUserToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :user_id, :integer, index: true
    add_column :users, :twitter_handler, :string
  end
end
