# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  team_id    :integer          not null
#  user_id    :integer          not null
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

describe Person, type: :model do
end
