class DropTableEventUsers < ActiveRecord::Migration[5.2]
  def change
    drop_table :event_users
  end
end
