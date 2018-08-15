class CreateCommunicationEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :communication_emails do |t|
      t.text :subject
      t.text :body

      t.timestamps
    end
  end
end
