class AddSeatsToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :seats, :integer, default: 0
  end
end
