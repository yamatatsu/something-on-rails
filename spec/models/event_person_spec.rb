# == Schema Information
#
# Table name: event_people
#
#  id         :integer          not null, primary key
#  event_id   :integer          not null
#  person_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_event_people_on_event_id   (event_id)
#  index_event_people_on_person_id  (person_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (person_id => people.id)
#

require 'rails_helper'

RSpec.describe EventPerson, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
