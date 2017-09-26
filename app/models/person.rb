# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_people_on_name     (name)
#  index_people_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Person < ApplicationRecord
  has_many :affiliations
  has_many :teams, through: :affiliations
  has_many :event_people
  has_many :events, through: :event_people
end
