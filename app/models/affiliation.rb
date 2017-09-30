# == Schema Information
#
# Table name: affiliations
#
#  id                :integer          not null, primary key
#  person_id         :integer          not null
#  team_id           :integer          not null
#  affiliation_year  :string(255)
#  dissociation_year :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_affiliations_on_person_id              (person_id)
#  index_affiliations_on_person_id_and_team_id  (person_id,team_id) UNIQUE
#  index_affiliations_on_team_id                (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (person_id => people.id)
#  fk_rails_...  (team_id => teams.id)
#

class Affiliation < ApplicationRecord
  belongs_to :person
  belongs_to :team
end
