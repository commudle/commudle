class AddSendDiscussionMailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :send_discussion_mails, :boolean, default: true
  end
end
