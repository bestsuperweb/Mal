class TeacherStuff < ActiveRecord::Base
	belongs_to :user

	def self.search(instrument)
		q = where("instrument LIKE ?", "#{instrument}").first
		if q
			return q
		else
			return false
		end
	end
end
