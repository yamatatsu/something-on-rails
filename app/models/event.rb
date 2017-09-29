# == Schema Information
#
# Table name: events
#
#  id              :integer          not null, primary key
#  name            :string(255)      not null
#  occurrence_year :string(255)
#  user_id         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_events_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Event < ApplicationRecord
  has_many :event_people, dependent: :destroy
  has_many :people, through: :event_people
end
