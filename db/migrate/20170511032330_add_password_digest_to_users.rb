class AddPasswordDigestToUsers < ActiveRecord::Migration[5.0]
  # rails g migration add_password_digest_to_users password_digest:string
  def change
    add_column :users, :password_digest, :string
  end
end
