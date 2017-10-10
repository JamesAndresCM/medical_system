class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.boolean :superadmin_role
      t.boolean :supervisor_role
      t.boolean :user_role, default: true
      t.references :user, foreign_key: true, index: true, on_delete: :cascade

      t.timestamps
    end
  end
end
