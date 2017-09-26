class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string     :name, null: false
      t.string     :color_code, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
