class AddAboutMeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :about_me, :text
    add_column :users, :designation, :string
    add_column :users, :personal_website, :text
    add_column :users, :linkedin, :text
    add_column :users, :github, :text
    add_column :users, :twitter, :text
  end
end
