# == Schema Information
#
# Table name: events
#
#  id              :integer          not null, primary key
#  name            :string(255)      not null
#  occurrence_year :integer
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
  belongs_to :user
  has_many :event_people, dependent: :destroy
  has_many :people, through: :event_people

  accepts_nested_attributes_for :event_people, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true, length: { maximum: 30 }
  validates :occurrence_year, presence: true, numericality: { only_integer: true }

  def teams
    people.map(&:team).uniq
  end
end
