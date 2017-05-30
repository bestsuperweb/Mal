class Lesson < ActiveRecord::Base
	belongs_to :user
	has_many :class_rooms, dependent: :destroy

	validates_presence_of :name, :instrument, :level, :description

	def class_requests?
		if class_rooms == []
			return false
		else
			if class_rooms.last.approve == false
				return true
			else
				return false
			end
		end
	end

	def requests
		class_rooms.where(approve: false)
	end

	def requests_count
		class_rooms.where(approve: false).count
	end
end
