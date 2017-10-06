# frozen_string_literal: true

# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  color_code :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_teams_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Team < ApplicationRecord
  belongs_to :user
  has_many :people, dependent: :restrict_with_error # 人物が消されるとショック大きそうだからエラーにしておく

  validates :name, presence: true, length: { maximum: 20 }
end
