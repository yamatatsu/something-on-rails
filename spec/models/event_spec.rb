# == Schema Information
#
# Table name: events
#
#  id              :integer          not null, primary key
#  name            :string(255)      not null
#  occurrence_year :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Event, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end