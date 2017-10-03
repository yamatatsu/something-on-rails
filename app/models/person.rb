# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  user_id    :integer          not null
#  team_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_people_on_name     (name)
#  index_people_on_team_id  (team_id)
#  index_people_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#  fk_rails_...  (user_id => users.id)
#

class Person < ApplicationRecord
  belongs_to :user
  belongs_to :team
  has_many :event_people, dependent: :destroy
  has_many :events, through: :event_people

  delegate :color_code, to: :team, prefix: true
end
