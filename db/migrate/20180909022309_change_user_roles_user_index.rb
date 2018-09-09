class ChangeUserRolesUserIndex < ActiveRecord::Migration[5.2]
  def change
    remove_index :user_roles_users, [:user_id, :user_role_id]
    add_index :user_roles_users, [:user_id, :user_role_id, :kommunity_id], name: :index_user_role_kommunity, unique: true
  end
end
