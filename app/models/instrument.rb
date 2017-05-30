class Instrument < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
end
