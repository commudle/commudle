class AddEventStatusToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :event_status, foreign_key: true, index: true
  end
end
