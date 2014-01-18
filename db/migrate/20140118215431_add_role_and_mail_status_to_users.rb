class AddRoleAndMailStatusToUsers < ActiveRecord::Migration
  def up
    add_column :users, :role, :string
    add_column :users, :mail_status, :boolean, defualt: false
  end

  def down
    remove_column :users, :role
    remove_column :users, :mail_status
  end
end
