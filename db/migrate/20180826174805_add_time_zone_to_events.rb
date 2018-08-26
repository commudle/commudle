class AddTimeZoneToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :timezone, :string
  end
end
