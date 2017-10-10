class RemoveRolesUser < ActiveRecord::Migration[5.1]
  def change
	remove_column :users, :superadmin_role
	remove_column :users, :supervisor_role
	remove_column :users, :user_role
  end
end
