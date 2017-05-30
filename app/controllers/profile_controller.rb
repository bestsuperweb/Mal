class ProfileController < ApplicationController
	layout "application"
	before_filter :authenticate_user!, except: :profile

	def profile
		@user = User.find_by_id(params[:id]) || current_user
		redirect_to root_path and return unless @user
		if @user.teacher?
			@stuff = @user.teacher_stuff
			@lessons = @user.lessons
			@teacher_activity = ClassRoom.teacher_activity(@user)
			@availabilities = @user.availabilities.today
			@requests = @user.class_rooms.requests
			@class_chats = @user.class_rooms.class_chats.active
			@completed = @user.class_rooms.class_chats.completed
			@credits = @user.credits.userd_not_redeemed

			render :teacher_profile
		else
			@student_activity = ClassRoom.student_activity(@user)
			@class_chats = @user.student_rooms.class_chats.active
			@credits = @user.credits.purchased_not_used

			render :student_profile
		end
	end

	def update
		current_user.update_attributes(user_params)
		redirect_to profile_path, notice: "Saved successfully!"
	end

	private

	def user_params
		params.require(:user).permit!
	end
end
