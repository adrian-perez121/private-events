class CreateEventsDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :events_details, id: false do |t|
      t.integer :event_id
      t.integer :attendee_id

      t.timestamps
    end
  end
end
