class AddPasswordToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password_digest, :string
  end
end

#adds a string col called password_digest to the user table
