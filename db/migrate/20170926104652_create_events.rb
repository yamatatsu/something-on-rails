class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string     :name, null: false
      t.string     :occurrence_year
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
