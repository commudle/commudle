class CreateDiscussionFollowers < ActiveRecord::Migration[5.2]
  def change
    create_table :discussion_followers do |t|
      t.references :discussion, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
