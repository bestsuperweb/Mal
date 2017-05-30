class MessagesController < ApplicationController
	before_filter :authenticate_user!, except: :create

	def create
		@class_room = ClassRoom.find(params[:class_room_id])
		@message = @class_room.messages.build(message_params)
		@message.user_id = current_user.try(:id)
		if @message.save
			@path = class_chat_path(@class_room)
		else
			@path = "/demo"
		end
	end

	private
		def message_params
			params.require(:message).permit(:body)
		end
end
