class CreateJoinTableUsersUserRoles < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :user_roles do |t|
      t.index [:user_id, :user_role_id], unique: true

      t.timestamps
    end
  end
end
