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

FactoryGirl.define do
  factory :person do
  end
end
