class Message < ActiveRecord::Base
	belongs_to :class_room
	belongs_to :user

	validates_presence_of :body, :class_room_id, :user_id
end
