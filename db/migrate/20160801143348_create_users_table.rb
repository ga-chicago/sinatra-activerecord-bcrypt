class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |table|
      table.string :username
      table.string :password
      table.string :email
    end
  end
end
