class CreateFixedEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :fixed_emails do |t|
      t.string :type
      t.string :subject
      t.text :message

      t.timestamps
    end
  end
end
