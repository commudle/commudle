class AddKommunityToUserRolesUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_roles_users, :kommunity, foreign_key: true, index: true
  end
end
