class CreateUsers < ActiveRecord::Migration[5.0]
  # rails g model User first_name:string last_name:string email:string
  # change the scheme by adding a users table with first_name last_name and
  # email attributes
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email

      t.timestamps
    end
  end
end
