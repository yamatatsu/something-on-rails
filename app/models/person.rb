# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_people_on_name  (name)
#

class Person < ApplicationRecord
  has_many :affiliations
  has_many :teams, through: :affiliations
  has_many :event_people
  has_many :events, through: :event_people
end
