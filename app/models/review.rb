class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :author, class_name: "User"

	after_create :avarage_user_score

	private

	def avarage_user_score
		user.update_attributes(current_rating: user.reviews.where("rate > 0").average(:rate).round)
	end
end
