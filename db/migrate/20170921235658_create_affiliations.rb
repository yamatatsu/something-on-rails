class CreateAffiliations < ActiveRecord::Migration[5.1]
  def change
    create_table :affiliations do |t|
      t.references :person, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.string     :affiliation_year
      t.string     :dissociation_year

      t.timestamps
    end
  end
end
