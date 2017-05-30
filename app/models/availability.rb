class Availability < ActiveRecord::Base
  belongs_to :user
  has_many :class_rooms, inverse_of: :availability, dependent: :destroy

  scope :today, -> { where('start_time >= ? AND end_time <= ?',
  	DateTime.now.beginning_of_day, DateTime.now.end_of_day.utc) }
end
