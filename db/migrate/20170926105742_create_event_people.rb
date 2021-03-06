class CreateEventPeople < ActiveRecord::Migration[5.1]
  def change
    create_table :event_people do |t|
      t.references :event, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end

    add_index :event_people, [:event_id, :person_id], unique: true
  end
end
