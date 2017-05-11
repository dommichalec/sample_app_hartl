# rails g migration add_index_to_users_email
class AddIndexToUsersEmail < ActiveRecord::Migration[5.0]
  # change the schema by adding an index to a user's email
  def change
    add_index :users, :email, unique: true
  end
end
