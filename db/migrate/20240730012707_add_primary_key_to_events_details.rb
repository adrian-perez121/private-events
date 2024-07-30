class AddPrimaryKeyToEventsDetails < ActiveRecord::Migration[7.1]
  def change
    add_column :events_details, :id, :primary_key
  end
end
