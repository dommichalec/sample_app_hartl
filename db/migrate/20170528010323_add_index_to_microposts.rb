# rails g migration AddIndexToMicroposts
class AddIndexToMicroposts < ActiveRecord::Migration[5.0]
  # With a multiple key index, Active Record uses both keys at the same time.
  def change
    add_index :microposts, [:user_id, :created_at]
  end
end
