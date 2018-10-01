class AddIdToUserRolesUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :user_roles_users, :id, :primary_key
  end
end
