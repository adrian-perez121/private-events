class CreateInvites < ActiveRecord::Migration[7.1]
  def change
    create_table :invites do |t|
      t.integer :invited_id
      t.integer :event_id

      t.timestamps
    end
  end
end
