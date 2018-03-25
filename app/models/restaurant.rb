# == Schema Information
#
# Table name: restaurants
#
#  id                        :integer          not null, primary key
#  name                      :string           not null
#  cuisine_id                :integer          not null
#  rating                    :integer
#  accepts_10bis             :boolean          default(FALSE)
#  address                   :string           not null
#  max_delivery_time_minutes :integer          default(90)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

class Restaurant < ApplicationRecord

  validates :name, :address, :accepts_10bis, :max_delivery_time_minutes, presence: true

  belongs_to :cuisine

end
